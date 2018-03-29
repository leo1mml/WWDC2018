import SpriteKit
import GameplayKit

public class PhysicsBodyComponent: GKComponent {
    public let node : SKPhysicsBody?
    
    public init(width: CGFloat, height: CGFloat) {
        self.node = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
