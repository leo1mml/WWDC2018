import SpriteKit
import GameplayKit

public class LivingRoomScene: SKScene, InteractionProtocol{
    
    var gameLayer: GameLayer?
    var inputLayer: InputLayer?
    var backgroundLayer: LivingRoomBackground?
    var hudLayer: HudLayer?
    public var switchSceneDelegate: SwitchScenesProtocol?
    var isFamilyPictureInFront: Bool = false
    var hasSeenPhoto = false
    var hasPetCat = false
    var hasSeenWWDC = false
    
    override public init(size: CGSize) {
        super.init(size: size)
        self.gameLayer = GameLayer(size: size)
        self.hudLayer = HudLayer(size: size)
        self.inputLayer = InputLayer(size: size, player: (self.gameLayer?.littleMug)!, interactionDelegate: self)
        self.backgroundLayer = LivingRoomBackground(size: size)
        configurePhysics()
        addLayers()
        print("completei o init")
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
        if(isFamilyPictureInFront){
            self.backgroundLayer?.picture?.backToNormal(position: CGPoint(x: (self.size.width)/2, y: (self.size.height) * 0.44))
            self.isFamilyPictureInFront = false
            return
        }
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
    
    func updateLabel(on littleMugX: CGFloat) {
        if(littleMugX < (self.size.width * 0.0555)){
            self.hudLayer?.messageLabel.text = "Bedroom"
        }else  if(littleMugX > self.size.width/3.8 && littleMugX < self.size.width * 0.4145) {
            if(!(self.backgroundLayer?.television?.tvIsOff)!){
                self.hudLayer?.messageLabel.text = "Turn off"
            } else {
                self.hudLayer?.messageLabel.text = "Turn on"
            }
        }else if(littleMugX >= self.size.width * 0.4145 && littleMugX <= self.size.width * 0.57263){
            self.hudLayer?.messageLabel.text = "See family picture"
        }else if(littleMugX > self.size.width * 0.6126 && littleMugX < self.size.width * 0.7525){
            self.hudLayer?.messageLabel.text = "Pet Cat"
        }else if(littleMugX > self.size.width * 0.77 && littleMugX < self.size.width){
            self.hudLayer?.messageLabel.text = "Go Outside"
        }else{
            self.hudLayer?.messageLabel.text = ""
        }
    }
    
    public func checkInteraction(on littleMugX: CGFloat) {
        if(littleMugX < (self.size.width * 0.0555)){
            self.switchSceneDelegate?.goToBedroom()
        }else  if(littleMugX > self.size.width/3.8 && littleMugX < self.size.width * 0.4145) {
            handleSeeWWDC()
        }else if(littleMugX >= self.size.width * 0.4145 && littleMugX <= self.size.width * 0.57263){
            handleSeePicture()
        }else if(littleMugX > self.size.width * 0.6126 && littleMugX < self.size.width * 0.7525){
            handlePetCat()
        }else if(littleMugX > self.size.width * 0.77 && littleMugX < self.size.width){
            self.switchSceneDelegate?.goOutside()
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
    
    func handleSeeWWDC() {
        self.backgroundLayer?.television?.switchTv()
        if(!hasSeenWWDC){
            self.hudLayer?.increaseJoyUnitsValue()
            self.hudLayer?.addJoyUnit()
            self.hasSeenWWDC = true
        }
    }
    
    func handlePetCat() {
        self.backgroundLayer?.cat?.catMeow()
        if(!self.hasPetCat){
            self.hudLayer?.increaseJoyUnitsValue()
            self.hudLayer?.addJoyUnit()
            self.hasPetCat = true
        }
    }
    
    func handleSeePicture() {
        if(isFamilyPictureInFront){
            self.backgroundLayer?.picture?.backToNormal(position: CGPoint(x: (self.size.width)/2, y: (self.size.height) * 0.44))
            self.isFamilyPictureInFront = false
            return
        }
        self.backgroundLayer?.picture?.expandPhoto()
        if(!hasSeenPhoto){
            self.hudLayer?.increaseJoyUnitsValue()
            self.hudLayer?.addJoyUnit()
            self.hasSeenPhoto = true
        }
        self.isFamilyPictureInFront = true
    }
}


