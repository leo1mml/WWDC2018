
import SpriteKit

public class GameLayer: SKNode {
    
    public var size: CGSize?
    var entityManager : EntityManager?
    public var littleMug: LittleMug?
    
    public init(size: CGSize) {
        super.init()
        self.size = size
        entityManager = EntityManager(layer: self)
        configureLayer()
    }
    
    
    func configureLayer() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: (self.size?.height)! * 0.15, width: (self.size?.width)!, height: (self.size?.height)! - ((self.size?.height)! * 0.1)))
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.categoryBitMask = PhysicsCategory.GameLayer
        self.physicsBody?.contactTestBitMask = PhysicsCategory.LittleMug
        createLittleMug()
    }
    
    func createLittleMug() {
        self.littleMug = LittleMug(imageName: "mug-idle-1", size: CGSize(width: (self.size?.height)! * 0.18, height: (self.size?.height)! * 0.3866))
        if let spriteComponent = self.littleMug?.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: (self.size?.width)!/7, y: (self.size?.height)! * 0.3467)
        }
        
        self.entityManager?.add(self.littleMug!)
        if let movementComponent = littleMug?.component(ofType: MovementComponent.self) {
            movementComponent.startIdleMode()
        }
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
