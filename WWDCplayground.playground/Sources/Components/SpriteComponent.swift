
import SpriteKit
import GameplayKit

public class SpriteComponent: GKComponent {
    
    public let node: SKSpriteNode
    
    public init(texture: SKTexture, size: CGSize) {
        node = SKSpriteNode(texture: texture, color: .white, size: size)
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
