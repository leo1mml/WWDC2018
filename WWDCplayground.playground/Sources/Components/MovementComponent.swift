import SpriteKit
import GameplayKit

public class MovementComponent: GKComponent {
    public var spriteComponent: SpriteComponent?
    public var isHappy = false
    
    public init(entity: GKEntity) {
        self.spriteComponent = entity.component(ofType: SpriteComponent.self)!
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startIdleMode() {
        guard let spriteNode = self.spriteComponent?.node else{
            return
        }
        
        var textureArray = [SKTexture]()
        if(self.isHappy){
            for index in 1 ... 2 {
                let textureName = "LittleMug/mug-happy-idle-\(index)"
                let texture = SKTexture(imageNamed: textureName)
                textureArray.append(texture)
            }
        }else {
            for index in 1 ... 2 {
                let textureName = "LittleMug/mug-idle-\(index)"
                let texture = SKTexture(imageNamed: textureName)
                textureArray.append(texture)
            }
        }
        
        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.4, resize: false, restore: false)
        let forever = SKAction.repeatForever(animate)
        spriteNode.run(forever)
    }
    
    public func startWalkingRightMode() {
        guard let spriteNode = self.spriteComponent?.node else{
            return
        }
        
        var textureArray = [SKTexture]()
        if(self.isHappy){
            for index in 1 ... 9 {
                let textureName = "LittleMug/mug-happy-walking-\(index)"
                let texture = SKTexture(imageNamed: textureName)
                textureArray.append(texture)
            }
        }else {
            for index in 1 ... 9 {
                let textureName = "LittleMug/mug-walking-\(index)"
                let texture = SKTexture(imageNamed: textureName)
                textureArray.append(texture)
            }
        }
        
        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.1, resize: false, restore: false)
        let forever = SKAction.repeatForever(animate)
        spriteNode.run(forever)
    }
    
    public func startWalkingLeftMode() {
        guard let spriteNode = self.spriteComponent?.node else{
            return
        }
        spriteNode.xScale = spriteNode.xScale * -1
        var textureArray = [SKTexture]()
        if(self.isHappy){
            for index in 1 ... 9 {
                let textureName = "LittleMug/mug-happy-walking-\(index)"
                let texture = SKTexture(imageNamed: textureName)
                textureArray.append(texture)
            }
        }else {
            for index in 1 ... 9 {
                let textureName = "LittleMug/mug-walking-\(index)"
                let texture = SKTexture(imageNamed: textureName)
                textureArray.append(texture)
            }
        }
        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.1, resize: false, restore: false)
        let forever = SKAction.repeatForever(animate)
        spriteNode.run(forever)
    }
    
}
