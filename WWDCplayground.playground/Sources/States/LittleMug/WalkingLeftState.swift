import SpriteKit
import GameplayKit

public class WalkingLeftState : GKState {
    public unowned let littleMug : LittleMug
    
    public init(littleMug: LittleMug) {
        self.littleMug = littleMug
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        if let spriteComponent = littleMug.component(ofType: SpriteComponent.self) {
            let spriteNode = spriteComponent.node
            if(spriteNode.xScale < 0){
                spriteNode.xScale = spriteNode.xScale * -1
            }
            spriteNode.physicsBody?.velocity = CGVector(dx: -100, dy: 0)
        }
        if let movementComponent = littleMug.component(ofType: MovementComponent.self) {
            movementComponent.startWalkingLeftMode()
        }
    }

    
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is WalkingLeftState.Type){
            return false
        }
        return true
    }
}
