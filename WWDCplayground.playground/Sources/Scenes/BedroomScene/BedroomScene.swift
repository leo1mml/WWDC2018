import SpriteKit
import GameplayKit

public class BedroomScene: SKScene, InteractionProtocol{
    let gameLayer: GameLayer?
    let backgroundLayer: BackgroundLayerBedroom?
    var inputLayer: InputLayer?
    let hudLayer: HudLayer?
    var isLaptopOn: Bool = true
    var joyUnits = 0
    var callSceneDelegate: SwitchScenesProtocol?
    var showInstructions = true
    var initialState: AnyClass
    
    var deltaTime: TimeInterval = 0
    var lastUpdateTimeInterval: TimeInterval = 0
    
    lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
        PlayingState(scene: self)
        ])
    
    init(size: CGSize, stateClass: AnyClass, joyUnits: Int, mugPosition: CGPoint) {
        initialState = stateClass
        gameLayer = GameLayer(size: size)
        backgroundLayer = BackgroundLayerBedroom(size: size)
        hudLayer = HudLayer(size: size)
        super.init(size: size)
        self.view?.isMultipleTouchEnabled = true
        self.gameLayer?.littleMug?.spriteComponent?.node.position = mugPosition
        stateMachine.enter(initialState)
        self.inputLayer = InputLayer(size: self.size, player: (self.gameLayer?.littleMug)!, interactionDelegate: self)
        addLayers()
    }
    
    func addLayers() {
        configurePhysics()
        self.addChild(self.backgroundLayer!)
        self.addChild(self.inputLayer!)
        self.addChild(self.hudLayer!)
        self.addChild(self.gameLayer!)
    }
    
    public override func didMove(to view: SKView) {
        if((self.hudLayer?.joyBar?.children.count)! <= (UserDefaults.standard.value(forKey: "joyUnits") as! Int)){
            self.hudLayer?.joyBar?.removeAllChildren()
            updateJoyUnits()
        }
        checkLittleMugHappiness()
    }
    
    func updateJoyUnits() {
        let joyUnits = UserDefaults.standard.value(forKey: "joyUnits") as! Int
        for index in 0...joyUnits {
            if(index > 0){
                self.hudLayer?.addJoyUnit()
            }
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if lastUpdateTimeInterval == 0 {
            lastUpdateTimeInterval = currentTime
        }
        if let littleMugX = self.gameLayer?.littleMug?.spriteComponent?.node.position.x {
            updateLabel(on: littleMugX)
        }
        deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        stateMachine.update(deltaTime: deltaTime)
        
    }
    
    func updateLabel(on littleMugX: CGFloat) {
        if(littleMugX > self.size.width/3.8 && littleMugX < self.size.width * 0.53) {
            if(self.backgroundLayer?.isLampOn)!{
                self.hudLayer?.messageLabel.text = "Turn off"
            } else {
                self.hudLayer?.messageLabel.text = "Turn on"
            }
        }else if(littleMugX > self.size.width * 0.77 && littleMugX < self.size.width){
            self.hudLayer?.messageLabel.text = "Living Room"
        }else{
            self.hudLayer?.messageLabel.text = ""
        }
    }
    
    public func checkInteraction(on littleMugX: CGFloat) {
        if(littleMugX > self.size.width/20 && littleMugX < self.size.width/3.8){
            enterSleepMode()
        }else  if(littleMugX > self.size.width/3.8 && littleMugX < self.size.width * 0.53) {
            if(self.backgroundLayer?.isLampOn)!{
                self.backgroundLayer?.turnOffDecoration()
            } else {
                self.backgroundLayer?.turnOnDecoration()
            }
        }else if(littleMugX > self.size.width * 0.77 && littleMugX < self.size.width){
            self.callSceneDelegate?.goToLivingRoom()
        }else{
            self.hudLayer?.messageLabel.text = ""
        }
        checkLittleMugHappiness()
    }
    
    func checkLittleMugHappiness() {
        if((UserDefaults.standard.value(forKey: "joyUnits") as! Int) > 2){
            if let movementComponent = self.gameLayer?.littleMug?.component(ofType: MovementComponent.self) {
                movementComponent.isHappy = true
                movementComponent.startIdleMode()
                self.gameLayer?.littleMug?.stateMachine?.enter(IdleState.self)
            }
        }
    }
    
    func enterSleepMode() {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundLayer?.gameInstructions?.alpha = 0.0
        inputLayer?.touchesBegan(touches, with: event)
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputLayer?.touchesMoved(touches, with: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputLayer?.touchesEnded(touches, with: event)
    }
    
    
}


