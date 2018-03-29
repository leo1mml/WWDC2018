
import GameplayKit
import SpriteKit

public class Cat : GKEntity {
    public var spriteComponent: SpriteComponent?
    public init(size: CGSize, imageName: String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        self.spriteComponent = SpriteComponent(texture: texture, size: size)
        self.addComponent(self.spriteComponent!)
    }
    
    public func catPurr() {
        if let sprite = self.component(ofType: SpriteComponent.self)?.node{
            let purrNoise = SKAction.playSoundFileNamed("Cat_Purr.mp3", waitForCompletion: false)
            sprite.run(purrNoise)
        }
    }
    
    public func catMeow() {
        if let sprite = self.component(ofType: SpriteComponent.self)?.node{
            let purrNoise = SKAction.playSoundFileNamed("Miau.mp3", waitForCompletion: false)
            sprite.run(purrNoise)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
