import GameplayKit
import SpriteKit

public class Skate: GKEntity {
    var size : CGSize
    public var skateSprite : SpriteComponent
    public init(size: CGSize, texture: SKTexture) {
        self.size = size
        self.skateSprite = SpriteComponent(texture: texture, size: size)
        super.init()
        self.addComponent(skateSprite)
    }
    
    public func fade() {
        let fade = SKAction.fadeOut(withDuration: 0)
        if let sprite = self.component(ofType: SpriteComponent.self)?.node {
            sprite.run(fade)
        }
    }
    
    public func show(){
        let show = SKAction.fadeIn(withDuration: 0)
        if let sprite = self.component(ofType: SpriteComponent.self)?.node {
            sprite.run(show)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
