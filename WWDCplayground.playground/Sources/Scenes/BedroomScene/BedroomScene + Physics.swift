
import SpriteKit
import GameplayKit

extension BedroomScene : SKPhysicsContactDelegate {
    
    public func configurePhysics() {
        self.physicsWorld.contactDelegate = self
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let categoryTuple = (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask)
        
        switch categoryTuple {
        case (PhysicsCategory.LittleMug, PhysicsCategory.GameLayer):
            handleMugAndScene(contactPoint: contact.contactPoint)
            break
        case (PhysicsCategory.GameLayer, PhysicsCategory.LittleMug):
            handleMugAndScene(contactPoint: contact.contactPoint)
            break
        default:
            return
        }
    }
    
    
    public func handleMugAndScene(contactPoint: CGPoint) {
        if(contactPoint.x > self.size.width * 0.996){
            hitRightWall()
        }
        if (contactPoint.y < self.size.height * 0.21){
            self.gameLayer?.littleMug?.isJumping = false
        }
    }
    
    public func hitRightWall() {
        self.gameLayer?.littleMug?.standStill()
    }
}
