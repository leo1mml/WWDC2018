import SpriteKit
import GameplayKit

public class LivingRoomBackground: SKNode {
    var size: CGSize?
    var entityManager : EntityManager?
    public var isTvOn: Bool = false
    public var television : Television?
    public var cat : Cat?
    public var picture: FamilyPicture?
    
    public init(size: CGSize) {
        self.size = size
        super.init()
        self.zPosition = -1
        self.entityManager = EntityManager(layer: self)
        createDecoration()
    }
    
    func createDecoration() {
        addFitment()
        hodor()
        addGround()
        addWall()
        addTV()
        addRightWindow()
        addLeftWindow()
        addCat()
        addFamilyPicture()
    }
    
    func addFamilyPicture() {
        self.picture = FamilyPicture(size: CGSize(width: (self.size?.width)! * 0.0525, height: (self.size?.height)! * 0.0853), textureName: "family-picture")
        if let sprite = self.picture?.spriteComponent?.node {
            sprite.position = CGPoint(x: (self.size?.width)!/2, y: (self.size?.height)! * 0.44)
            sprite.zPosition = -1
        }
        self.entityManager?.add(self.picture!)
    }
    
    func addFitment(){
        let fitment = SKSpriteNode(imageNamed: "fitment")
        fitment.size = CGSize(width: (self.size?.width)! * 0.375, height: (self.size?.height)! * 0.62)
        fitment.position = CGPoint(x: (self.size?.width)!/2.5, y: (self.size?.height)!/2 + (self.size?.height)!/25)
        fitment.zPosition = -2
        self.addChild(fitment)
    }
    
    func addTV() {
        self.television = Television(size: CGSize(width: (self.size?.width)! * 0.174, height: (self.size?.height)! * 0.176), imageName: "tv-off")
        if let sprite = television?.spriteComponent?.node {
            sprite.position = CGPoint(x: (self.size?.width)!/2.45, y: (self.size?.height)!/2 + (self.size?.height)!/12.5)
        }
        self.entityManager?.add(television!)
    }
    
    func addCat(){
        self.cat = Cat(size: CGSize(width: (self.size?.width)! * 0.075, height: (self.size?.height)! * 0.1653), imageName: "cat")
        if let sprite = self.cat?.spriteComponent?.node {
            sprite.position = CGPoint(x: (self.size?.width)! * 0.7, y: (self.size?.height)! * 0.47)
            sprite.xScale = sprite.xScale * -1
        }
        self.entityManager?.add(self.cat!)
    }
    
    func hodor() {
        let door = SKSpriteNode(imageNamed: "door")
        door.size = CGSize(width: (self.size?.width)! * 0.224, height: (self.size?.height)! * 0.63)
        door.position = CGPoint(x: (self.size?.width)! - (self.size?.width)! * 0.125, y: (self.size?.height)!/1.84)
        door.zPosition = -1
        self.addChild(door)
    }
    
    func addRightWindow() {
        let rightWindow = SKSpriteNode(imageNamed: "right-window")
        rightWindow.size = CGSize(width: (self.size?.width)! * 0.108, height: (self.size?.height)! * 0.5627)
        rightWindow.position = CGPoint(x: (self.size?.width)! * 0.7, y: (self.size?.height)! * 0.57)
        rightWindow.zPosition = -2
        self.addChild(rightWindow)
        let windowLight = SKSpriteNode(imageNamed: "window-light")
        windowLight.size = CGSize(width: (self.size?.width)! * 0.156, height: (self.size?.height)! * 0.075)
        windowLight.position = CGPoint(x: rightWindow.position.x, y: rightWindow.position.y * 0.3)
        self.addChild(windowLight)
    }
    func addLeftWindow() {
        let leftWindow = SKSpriteNode(imageNamed: "left-window")
        leftWindow.size = CGSize(width: (self.size?.width)! * 0.108, height: (self.size?.height)! * 0.5627)
        leftWindow.position = CGPoint(x: (self.size?.width)! * 0.15, y: (self.size?.height)! * 0.57)
        self.addChild(leftWindow)
        let windowLight = SKSpriteNode(imageNamed: "window-light")
        windowLight.size = CGSize(width: (self.size?.width)! * 0.156, height: (self.size?.height)! * 0.075)
        windowLight.position = CGPoint(x: leftWindow.position.x, y: leftWindow.position.y * 0.3)
        self.addChild(windowLight)
    }
    
    func addGround() {
        let ground = SKSpriteNode(imageNamed: "bedroom-ground")
        ground.zPosition = -3
        ground.size = CGSize(width: (self.size?.width)!, height: (self.size?.height)! * 0.2)
        ground.position = CGPoint(x: (self.size?.width)!/2, y:(self.size?.height)! * 0.2)
        self.addChild(ground)
    }
    
    func addWall() {
        let wall = SKSpriteNode(imageNamed: "bedroom-wall")
        wall.zPosition = -3
        wall.size = CGSize(width: (self.size?.width)!, height: (self.size?.height)! * 0.8)
        wall.position = CGPoint(x: (self.size?.width)!/2, y: (self.size?.height)!/2 + (self.size?.height)! * 0.2)
        self.addChild(wall)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
