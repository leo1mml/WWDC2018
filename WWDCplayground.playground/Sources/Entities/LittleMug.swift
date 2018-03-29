import SpriteKit
import GameplayKit

public class LittleMug: GKEntity {
    public var spriteComponent : SpriteComponent?
    public var movementComponent: MovementComponent?
    public var physicsBodyComponent: PhysicsBodyComponent?
    public var stateMachine : GKStateMachine?
    public var isJumping = false
    public var isHappy = false
    public var isSkating = false
    public var isSitting = false
    public var size: CGSize?
    
    public init(imageName: String, size: CGSize) {
        super.init()
        self.size = size
        let texture = SKTexture(imageNamed: imageName)
        
        self.spriteComponent = SpriteComponent(texture: texture, size: size)
        self.addComponent(self.spriteComponent!)
        
        self.movementComponent = MovementComponent(entity: self)
        self.addComponent(movementComponent!)
        
        self.spriteComponent?.node.isUserInteractionEnabled = false
        configurePhysics()
        self.stateMachine = GKStateMachine(states: [
            IdleState(littleMug: self),
            WalkingRightState(littleMug: self),
            WalkingLeftState(littleMug: self),
            JumpingUpState(littleMug: self),
            SkatingRightState(littleMug: self),
            SkatingLeftState(littleMug: self),
            SitState(littleMug: self)
            ])
    }
    
    func configurePhysics() {
        self.physicsBodyComponent = PhysicsBodyComponent(width: (self.size?.width)!, height: (self.size?.height)!)
        if let sprite = self.spriteComponent?.node{
            sprite.physicsBody = self.physicsBodyComponent?.node
            if let physicsBody = sprite.physicsBody{
                physicsBody.friction = 0.0
                physicsBody.restitution = 0.0
                physicsBody.linearDamping = 0.0
                physicsBody.categoryBitMask = PhysicsCategory.LittleMug
                physicsBody.contactTestBitMask = PhysicsCategory.GameLayer | PhysicsCategory.Bed | PhysicsCategory.Decoration
                physicsBody.collisionBitMask = PhysicsCategory.Skate | PhysicsCategory.GameLayer
                physicsBody.allowsRotation = false
            }
        }
    }
    
    public func walkRight(){
        self.stateMachine?.enter(WalkingRightState.self)
    }
    public func walkLeft(){
        self.stateMachine?.enter(WalkingLeftState.self)
    }
    
    public func jumpUp() {
        self.stateMachine?.enter(JumpingUpState.self)
    }
    
    public func standStill() {
        self.isSkating = false
        self.isSitting = false
        self.stateMachine?.enter(IdleState.self)
    }
    
    public func skateRight() {
        self.stateMachine?.enter(SkatingRightState.self)
    }
    
    public func skateLeft() {
        self.stateMachine?.enter(SkatingLeftState.self)
    }
    
    public func sitIn(position: CGPoint) {
        if let spriteComponent = self.component(ofType: SpriteComponent.self){
            let sprite = spriteComponent.node
            sprite.position = position
        }
        self.stateMachine?.enter(SitState.self)
    }
    
    public func idleIn(position: CGPoint){
        if let spriteComponent = self.component(ofType: SpriteComponent.self){
            let sprite = spriteComponent.node
            sprite.position = position
        }
        self.stateMachine?.enter(IdleState.self)
    }
    
    public func stopSkating() {
        self.stateMachine?.enter(IdleState.self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
