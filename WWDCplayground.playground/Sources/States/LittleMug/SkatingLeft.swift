import GameplayKit
import SpriteKit

public class SkatingLeftState: GKState {
    public unowned let littleMug : LittleMug
    
    public init(littleMug: LittleMug) {
        self.littleMug = littleMug
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        if let spriteComponent = littleMug.component(ofType: SpriteComponent.self) {
            let spriteNode = spriteComponent.node
            spriteNode.removeAllActions()
            self.littleMug.isSkating = true
            if(self.littleMug.isHappy){
                let skatingTexture = SKTexture(imageNamed: "LittleMug/mug-happy-skating")
                spriteNode.texture = skatingTexture
            }else {
                let skatingTexture = SKTexture(imageNamed: "LittleMug/mug-skating")
                spriteNode.texture = skatingTexture
            }
            if(spriteNode.xScale > 0){
                spriteNode.xScale = spriteNode.xScale * -1
            }
            spriteNode.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
        }
    }
    
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is SkatingRightState.Type || stateClass is IdleState.Type || stateClass is JumpingUpState.Type){
            return true
        }
        return false
    }
}
