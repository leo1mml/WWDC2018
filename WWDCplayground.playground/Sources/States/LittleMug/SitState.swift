import GameplayKit
import SpriteKit

public class SitState: GKState {
    
    public unowned let littleMug : LittleMug
    
    public init(littleMug: LittleMug) {
        self.littleMug = littleMug
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        if let spriteComponent = littleMug.component(ofType: SpriteComponent.self) {
            let spriteNode = spriteComponent.node
            spriteNode.removeAllActions()
            spriteNode.physicsBody?.isResting = true
            spriteNode.physicsBody?.isDynamic = false
            self.littleMug.isSitting = true
            if(!self.littleMug.isHappy){
                spriteNode.texture = SKTexture(imageNamed: "LittleMug/mug-sitting")
            }else {
                spriteNode.texture = SKTexture(imageNamed: "LittleMug/mug-happy-sitting")
            }
        }
    }
    
    override public func willExit(to nextState: GKState) {
        self.littleMug.isSitting = false
        if let component = self.littleMug.component(ofType: SpriteComponent.self){
            let spriteNode = component.node
            self.littleMug.isSitting = false
            spriteNode.physicsBody?.isResting = false
            spriteNode.physicsBody?.isDynamic = true
        }
        
    }
    
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if(stateClass is IdleState.Type){
            return true
        }
        return false
    }
}
