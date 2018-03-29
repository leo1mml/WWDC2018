import GameplayKit
import SpriteKit

public class Television: GKEntity {
    public var spriteComponent: SpriteComponent?
    public var tvIsOff = true
    public init(size: CGSize, imageName: String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        self.spriteComponent = SpriteComponent(texture: texture, size: size)
        self.addComponent(self.spriteComponent!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func switchTv() {
        if let sprite = self.spriteComponent?.node{
            if self.tvIsOff {
                let texture = SKTexture(imageNamed: "tv")
                sprite.texture = texture
                self.tvIsOff = false
            }else {
                let texture = SKTexture(imageNamed: "tv-off")
                sprite.texture = texture
                self.tvIsOff = true
            }
        }
    }
}
