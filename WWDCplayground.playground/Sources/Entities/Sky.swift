
import GameplayKit
import SpriteKit

public class Sky: GKEntity {
    
    public var skySprite: SpriteComponent?
    var size: CGSize
    
    public init(size: CGSize) {
        self.size = size
        super.init()
        self.skySprite = SpriteComponent(texture: SKTexture.init(imageNamed: "sky"), size: size)
        self.addComponent(self.skySprite!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func orangefy() {
        let colorfy = SKAction.colorize(with: UIColor().hexStringToUIColor(hex: "#FF9700"), colorBlendFactor: 1.0, duration: 2)
        self.skySprite?.node.colorBlendFactor = 1.0
        self.skySprite?.node.run(colorfy)
    }
}
