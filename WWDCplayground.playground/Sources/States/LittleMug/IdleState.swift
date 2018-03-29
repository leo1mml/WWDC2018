import GameplayKit
import SpriteKit

public class IdleState: GKState {
    public unowned let littleMug: LittleMug
    
    public init(littleMug: LittleMug) {
        self.littleMug = littleMug
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        
        
        if let moveComponent = self.littleMug.component(ofType: MovementComponent.self){
            moveComponent.startIdleMode()
        }
        if let spriteComponent = littleMug.component(ofType: SpriteComponent.self) {
            let spriteNode = spriteComponent.node
            spriteNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            spriteNode.physicsBody?.isResting = true
        }
    }
    
    public override func willExit(to nextState: GKState) {
        if let spriteComponent = littleMug.component(ofType: SpriteComponent.self) {
            let spriteNode = spriteComponent.node
            spriteNode.physicsBody?.isResting = false
        }
    }
    
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is IdleState.Type){
            return false
        }
        return true
    }

}
