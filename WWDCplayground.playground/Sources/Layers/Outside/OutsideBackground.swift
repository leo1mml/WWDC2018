
import SpriteKit
import GameplayKit

public class OutsideBackground: SKNode {
    var size: CGSize
    var entityManager: EntityManager?
    public var sky : Sky?
    public var sun : Sun?
    public var clouds: Clouds?
    public var skate : Skate?
    
    public init(size: CGSize) {
        self.size = size
        super.init()
        self.zPosition = -1
        self.entityManager = EntityManager(layer: self)
        addLayers()
    }
    
    func addLayers() {
        addGrassGround()
        addSky()
        addSeat()
        addMountains()
        addTrees()
        addSun()
        addClouds()
        addSkate()
    }
    
    func addGrassGround() {
        let sprite = SKSpriteNode(imageNamed: "grass-ground")
        sprite.size = CGSize(width: (self.size.width), height: (self.size.height) * 0.7)
        sprite.position = CGPoint(x: (self.size.width)/2, y: (self.size.height) * 0.44)
        sprite.zPosition = -3
        self.addChild(sprite)
    }
    
    func addSky() {
        self.sky = Sky(size: CGSize(width: (self.size.width), height: (self.size.height) * 0.55))
        if let spriteSky = self.sky?.skySprite?.node {
            spriteSky.position = CGPoint(x: (self.size.width)/2, y: (self.size.height) * 0.72)
            spriteSky.zPosition = -20
            spriteSky.colorBlendFactor = 1.0
            spriteSky.color = UIColor().hexStringToUIColor(hex: "#23A4F5")
        }
        self.entityManager?.add(self.sky!)
    }
    
    func addSeat() {
        let seatSprite = SKSpriteNode(imageNamed: "seat")
        seatSprite.size = CGSize(width: (self.size.width) * 0.282, height: (self.size.height) * 0.25)
        seatSprite.position = CGPoint(x: (self.size.width)/2, y: (self.size.height) * 0.4)
        seatSprite.zPosition = -2
        self.addChild(seatSprite)
    }
    
    func addMountains() {
        let mountainsSprite = SKSpriteNode(imageNamed: "mountains")
        mountainsSprite.size = CGSize(width: (self.size.width), height: (self.size.height) * 0.456)
        mountainsSprite.position = CGPoint(x: (self.size.width)/2, y: (self.size.height) * 0.4)
        mountainsSprite.zPosition = -5
        self.addChild(mountainsSprite)
    }
    
    func addTrees() {
        let trees = SKSpriteNode(imageNamed: "trees")
        trees.size = CGSize(width: self.size.width * 0.99, height: self.size.height * 0.59)
        trees.position = CGPoint(x: self.size.width * 0.51, y: self.size.height * 0.57)
        trees.zPosition = -2
        self.addChild(trees)
    }
    
    func addSun() {
        self.sun = Sun(size: CGSize.init(width: self.size.height * 0.1466666, height: self.size.height * 0.1466666), textureName: "sun")
        self.sun?.spriteComponent?.node.position = CGPoint(x: self.size.width * 0.4, y: self.size.height * 0.8)
        self.sun?.spriteComponent?.node.zPosition = -8
        self.entityManager?.add(self.sun!)
    }
    
    func addClouds() {
        self.clouds = Clouds(size: CGSize(width: self.size.width * 0.95, height: self.size.height * 0.475), texture: SKTexture(imageNamed: "clouds"))
        if let sprite = self.clouds?.component(ofType: SpriteComponent.self)?.node {
            sprite.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.7)
            sprite.zPosition = -6
        }
        self.entityManager?.add(self.clouds!)
    }
    
    func addSkate() {
        self.skate = Skate(size: CGSize.init(width: self.size.width * 0.11544228, height: self.size.height * 0.05066), texture: SKTexture(imageNamed: "skate"))
        if let sprite = self.skate?.component(ofType: SpriteComponent.self)?.node {
            sprite.position = CGPoint(x: self.size.width/4.5, y: self.size.height * 0.28)
            sprite.zPosition = -1
        }
        self.entityManager?.add(self.skate!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
