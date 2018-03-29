import SpriteKit
import GameplayKit

public class JumpingUpState : GKState {
    public unowned let littleMug : LittleMug
    
    
    public init(littleMug: LittleMug) {
        self.littleMug = littleMug
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        if let spriteComponent = littleMug.component(ofType: SpriteComponent.self) {
            let spriteNode = spriteComponent.node
            if(!self.littleMug.isJumping){
                spriteNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
                self.littleMug.isJumping = true
            }
        }
    }
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass is JumpingUpState.Type {
            return false
        }
        return true
    }
}
