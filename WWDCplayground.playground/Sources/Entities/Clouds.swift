import GameplayKit
import SpriteKit

public class Clouds : GKEntity {
    public var cloudsSprite: SpriteComponent?
    
    public init(size: CGSize, texture: SKTexture) {
        self.cloudsSprite = SpriteComponent(texture: texture, size: size)
        super.init()
        self.addComponent(self.cloudsSprite!)
    }
    
    public func fade() {
        if let clouds = self.component(ofType: SpriteComponent.self)?.node {
            let fade = SKAction.fadeOut(withDuration: 3)
            clouds.run(fade)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
