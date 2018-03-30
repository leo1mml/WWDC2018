import GameplayKit
import SpriteKit

public class FamilyPicture: GKEntity {
    public var spriteComponent: SpriteComponent?
    
    public init(size: CGSize, textureName: String) {
        super.init()
        self.spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: textureName), size: size)
        self.addComponent(self.spriteComponent!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func expandPhoto() {
        if let sprite = self.spriteComponent?.node {
            sprite.zPosition = 10
            let rotate = SKAction.rotate(byAngle: CGFloat(Double.pi * 2), duration: 0.5)
            let expand = SKAction.scale(to: 5, duration: 0.5)
            let group = SKAction.group([rotate, expand])
            sprite.run(group)
        }
    }
    
    public func backToNormal(position: CGPoint, completion: (() -> ())? = nil) {
        if let sprite = self.spriteComponent?.node {
            sprite.zPosition = -1
            let rotate = SKAction.rotate(byAngle: CGFloat(Double.pi * 2), duration: 0.5)
            let expand = SKAction.scale(to: 1, duration: 0.5)
            let group = SKAction.group([rotate, expand])
            sprite.run(group){
                completion?()
            }
        }
    }
}
