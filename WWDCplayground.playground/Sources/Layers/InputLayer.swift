import SpriteKit

public protocol InteractionProtocol {
    func checkInteraction(on littleMugX: CGFloat)
}

public class InputLayer: SKNode {
    var size : CGSize
    public var player : LittleMug
    let analogJoystickBase = SKShapeNode(circleOfRadius: 50)
    let analogJoystickBall = SKShapeNode(circleOfRadius: 12.5)
    var deg : CGFloat?
    public var interactionDelegate : InteractionProtocol?
    var entityManager: EntityManager?
    
    public init(size: CGSize, player: LittleMug, interactionDelegate: InteractionProtocol) {
        self.size = size
        self.player = player
        self.interactionDelegate = interactionDelegate
        super.init()
        self.entityManager = EntityManager(layer: self)
        placeAnalog()
    }
    
    
    func placeAnalog() {
        let basePosition = CGPoint(x: self.size.width/4, y: self.size.height/3)
        analogJoystickBall.fillColor = .darkGray
        self.analogJoystickBase.position = basePosition
        self.addChild(analogJoystickBase)
        self.analogJoystickBall.position = basePosition
        self.analogJoystickBase.fillColor = .gray
        self.addChild(analogJoystickBall)
        self.analogJoystickBall.alpha = 0.0
        self.analogJoystickBase.alpha = 0.0
        self.analogJoystickBall.lineWidth = 0.0
        self.analogJoystickBase.lineWidth = 0.0
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isLeftLocation(location: CGPoint) -> Bool {
        return location.x < self.size.width/2
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            if(isLeftLocation(location: location)){
                self.analogJoystickBall.position = location
                self.analogJoystickBase.position = location
                self.analogJoystickBall.alpha = 0.5
                self.analogJoystickBase.alpha = 0.3
            }else {
                interactionDelegate?.checkInteraction(on: (self.player.spriteComponent?.node.position.x)!)
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            if(isLeftLocation(location: location)){
                let v = CGVector(dx: location.x - analogJoystickBase.position.x, dy: location.y - analogJoystickBase.position.y)
                let angle = atan2(v.dx, v.dy)
                
                self.deg = angle * CGFloat(180 / Double.pi)
                if(deg!  < CGFloat(120) && deg! > CGFloat(70)){
                    if(self.player.isSkating){
                        self.player.skateRight()
                    }else {
                        self.player.walkRight()
                    }
                    
                } else if(deg!  > CGFloat(-120) && deg! < CGFloat(-70)){
                    if(self.player.isSkating) {
                        self.player.skateLeft()
                    }else {
                        self.player.walkLeft()
                    }
                } else if(deg!  >= CGFloat(-70) && deg! < CGFloat(70)){
                    let centerDistance = self.analogJoystickBall.position.y - self.analogJoystickBase.position.y
                    if(centerDistance > (self.analogJoystickBase.frame.size.width * 0.3)){
                        self.player.jumpUp()
                    }
                }
                
                let length : CGFloat = analogJoystickBase.frame.size.height / 2
                
                let xDistance : CGFloat = sin(angle - CGFloat(Double.pi)) * length
                let yDistance : CGFloat = cos(angle - CGFloat(Double.pi)) * length
                
                
                if(self.analogJoystickBase.contains(location)){
                    self.analogJoystickBall.position = location
                }else {
                    analogJoystickBall.position = CGPoint(x: analogJoystickBase.position.x - xDistance, y: analogJoystickBase.position.y - yDistance)
                }
            }
            
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            if(isLeftLocation(location: location)){
                let moveAction = SKAction.move(to: self.analogJoystickBase.position, duration: 0.2)
                moveAction.timingMode = .easeOut
                
                self.analogJoystickBall.run(moveAction)
                if(!self.player.isSitting && !self.player.isSkating){
                    self.player.standStill()
                }
                self.analogJoystickBall.alpha = 0.0
                self.analogJoystickBase.alpha = 0.0
            }
        }
    }
    
    
}
