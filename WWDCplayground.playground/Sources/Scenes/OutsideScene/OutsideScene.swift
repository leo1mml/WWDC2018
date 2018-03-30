import SpriteKit
import GameplayKit

public class OutsideScene: SKScene, InteractionProtocol{
    
    var gameLayer: GameLayer?
    var inputLayer: InputLayer?
    var backgroundLayer: OutsideBackground?
    var hudLayer: HudLayer?
    var switchSceneDelegate: SwitchScenesProtocol?
    var hasUsedSkate = false
    var hasSeenSunset = false
    
    public override init(size: CGSize) {
        super.init(size: size)
        self.gameLayer = GameLayer(size: size)
        self.hudLayer = HudLayer(size: size)
        self.inputLayer = InputLayer(size: size, player: (self.gameLayer?.littleMug)!, interactionDelegate: self)
        self.backgroundLayer = OutsideBackground(size: size)
        configurePhysics()
        addLayers()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func didMove(to view: SKView) {
        if((self.hudLayer?.joyBar?.children.count)! <= (UserDefaults.standard.value(forKey: "joyUnits") as! Int)){
            self.hudLayer?.joyBar?.removeAllChildren()
            updateJoyUnits()
        }
        checkLittleMugHappiness()
        
    }
    
    func sunset() {
        self.backgroundLayer?.sky?.orangefy()
        self.backgroundLayer?.clouds?.fade()
        self.backgroundLayer?.sun?.goDown(completion: {
            if((UserDefaults.standard.value(forKey: "joyUnits") as! Int) > 4){
                self.switchSceneDelegate?.endGame()
            }
        })
    }
    
    func updateJoyUnits() {
        let joyUnits = UserDefaults.standard.value(forKey: "joyUnits") as! Int
        for index in 0...joyUnits {
            if(index > 0){
                self.hudLayer?.addJoyUnit()
            }
        }
    }
    
    func addLayers() {
        self.addChild(gameLayer!)
        self.addChild(inputLayer!)
        self.addChild(backgroundLayer!)
        self.addChild(hudLayer!)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inputLayer?.touchesBegan(touches, with: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inputLayer?.touchesMoved(touches, with: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.inputLayer?.touchesEnded(touches, with: event)
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if let littleMugX = self.gameLayer?.littleMug?.spriteComponent?.node.position.x {
            updateLabel(on: littleMugX)
        }
    }
    
    public func updateLabel(on littleMugX: CGFloat) {
        if(littleMugX < (self.size.width * 0.0555)){
            self.hudLayer?.messageLabel.text = "Go back to House"
        }
        if(littleMugX > self.size.width * 0.120 && littleMugX < self.size.width * 0.3327){
            self.hudLayer?.messageLabel.text = "Skate"
        }else if((littleMugX > self.size.width * 0.334 && littleMugX < self.size.width * 0.672) && !self.hasSeenSunset){
            self.hudLayer?.messageLabel.text = "Sit and wait for the sunrise"
        }else {
            self.hudLayer?.messageLabel.text = ""
        }
    }
    
    
    public func checkInteraction(on littleMugX: CGFloat) {
        if(self.gameLayer?.littleMug?.isSkating)!{
            handleSkate()
            return
        }
        if(littleMugX < (self.size.width * 0.0555)){
            self.switchSceneDelegate?.goToLivingRoom()
        }
        if(littleMugX > self.size.width * 0.120 && littleMugX < self.size.width * 0.3327){
            handleSkate()
        }else if(littleMugX > self.size.width * 0.334 && littleMugX < self.size.width * 0.672){
            handleSunset()
        }
        checkLittleMugHappiness()
    }
    
    func handleSkate() {
        if(!self.hasUsedSkate){
            self.hasUsedSkate = true
            self.hudLayer?.increaseJoyUnitsValue()
            self.hudLayer?.addJoyUnit()
        }
        if(self.gameLayer?.littleMug?.isSkating)!{
            self.backgroundLayer?.skate?.show(completion: {
                if((UserDefaults.standard.value(forKey: "joyUnits") as! Int) > 4){
                    self.switchSceneDelegate?.endGame()
                }
            })
            self.gameLayer?.littleMug?.standStill()
        }else {
            self.backgroundLayer?.skate?.fade()
            self.gameLayer?.littleMug?.skateRight()
        }
    }
    
    func handleSunset() {
        if(self.gameLayer?.littleMug?.isSitting)!{
            self.gameLayer?.littleMug?.idleIn(position: CGPoint(x: self.size.width/2, y: self.size.height * 0.3467))
        }else if(!(self.gameLayer?.littleMug?.isSkating)!){
            waitForSunset()
        }
    }
    
    func waitForSunset() {
        if(!self.hasSeenSunset){
            sunset()
            self.hasSeenSunset = true
            self.hudLayer?.increaseJoyUnitsValue()
            self.hudLayer?.addJoyUnit()
        }
        self.gameLayer?.littleMug?.sitIn(position: CGPoint(x: self.size.width/2, y: self.size.height * 0.5))
    }
    
    func checkLittleMugHappiness() {
        if((UserDefaults.standard.value(forKey: "joyUnits") as! Int) > 2){
            self.gameLayer?.littleMug?.isHappy = true
            if let movementComponent = self.gameLayer?.littleMug?.component(ofType: MovementComponent.self) {
                movementComponent.isHappy = true
                if(!(self.gameLayer?.littleMug?.isSitting)! && !(self.gameLayer?.littleMug?.isSkating)!){
                    self.gameLayer?.littleMug?.stateMachine?.enter(IdleState.self)
                    movementComponent.startIdleMode()
                }
            }
        }
    }
    
}
