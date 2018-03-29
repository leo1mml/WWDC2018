import SpriteKit
import GameplayKit

public class BackgroundLayerBedroom: SKNode {
    var size: CGSize?
    var entityManager : EntityManager?
    public var isLampOn = false
    public var decoration : SKSpriteNode?
    var gameInstructions: SKSpriteNode?
    
    public init(size: CGSize) {
        super.init()
        self.size = size
        entityManager = EntityManager(layer: self)
        createLayers()
    }
    
    func createLayers() {
        addGround()
        addWall()
        addDecoration()
        addBed()
        hodor()
        addGameInstructions()
    }
    
    func hodor() {
        let door = SKSpriteNode(imageNamed: "door")
        door.size = CGSize(width: (self.size?.width)! * 0.224, height: (self.size?.height)! * 0.63)
        door.position = CGPoint(x: (self.size?.width)! - (self.size?.width)! * 0.125, y: (self.size?.height)!/1.84)
        door.zPosition = -1
        self.addChild(door)
    }
    
    func addGameInstructions() {
        self.gameInstructions = SKSpriteNode(imageNamed: "game-instructions")
        self.gameInstructions?.position = CGPoint(x: (self.size?.width)!/2, y: (self.size?.height)!/2)
        self.gameInstructions?.size = CGSize(width: (self.size?.width)! * 0.88, height: (self.size?.height)! * 0.88)
        self.gameInstructions?.zPosition = 30
        self.addChild(self.gameInstructions!)
    }
    
    func addGround() {
        let ground = SKSpriteNode(imageNamed: "bedroom-ground")
        ground.zPosition = -2
        ground.size = CGSize(width: (self.size?.width)!, height: (self.size?.height)! * 0.2)
        ground.position = CGPoint(x: (self.size?.width)!/2, y:(self.size?.height)! * 0.2)
        self.addChild(ground)
    }
    
    func addWall() {
        let wall = SKSpriteNode(imageNamed: "bedroom-wall")
        wall.zPosition = -2
        wall.size = CGSize(width: (self.size?.width)!, height: (self.size?.height)! * 0.8)
        wall.position = CGPoint(x: (self.size?.width)!/2, y: (self.size?.height)!/2 + (self.size?.height)! * 0.2)
        self.addChild(wall)
    }
    
    func addDecoration() {
        self.decoration = SKSpriteNode(imageNamed: "bedroom-decoration-off")
        if let bedroomDecoration = self.decoration {
            bedroomDecoration.size = CGSize(width: (self.size?.width)! * 0.7, height: (self.size?.height)! * 0.82)
            bedroomDecoration.position = CGPoint(x: (self.size?.width)!/2.2, y: (self.size?.height)!/2 + (self.size?.height)! * 0.088)
            bedroomDecoration.zPosition = -1
        }
        
        self.addChild(self.decoration!)
    }
    
    func addBed() {
        let bed = SKSpriteNode(imageNamed: "bed")
        bed.zPosition = -1
        bed.position = CGPoint(x: (self.size?.width)! * 0.15, y: (self.size?.height)! * 0.35)
        bed.size = CGSize(width: (self.size?.width)! * 0.26, height: (self.size?.height)! * 0.3)
        self.addChild(bed)
    }
    
    
    public func turnOffDecoration(){
        let textureOff = SKTexture.init(imageNamed: "bedroom-decoration-off")
        self.decoration?.texture = textureOff
        self.isLampOn = false
    }
    
    public func turnOnDecoration() {
        let textureOn = SKTexture(imageNamed: "bedroom-decoration")
        self.decoration?.texture = textureOn
        let turnOn = SKAction.playSoundFileNamed("Startup-mac.wav", waitForCompletion: false)
        self.run(turnOn)
        self.isLampOn = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
