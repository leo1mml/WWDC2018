
import GameplayKit
import SpriteKit

public class Sun: GKEntity {
    public var spriteComponent: SpriteComponent?
    let size: CGSize
    
    public init(size: CGSize, textureName: String) {
        self.size = size
        super.init()
        self.spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: textureName), size: size)
        self.addComponent(self.spriteComponent!)
    }
    
    public func goDown() {
        if let sprite = self.component(ofType: SpriteComponent.self)?.node {
            let expand = SKAction.scale(to: 4, duration: 5)
            let moveDown = SKAction.move(to: CGPoint.init(x: size.width * 9, y: self.size.height * 4), duration: 5)
            let group = SKAction.group([expand, moveDown])
            sprite.run(group)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
