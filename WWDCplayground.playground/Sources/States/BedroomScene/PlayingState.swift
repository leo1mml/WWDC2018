import SpriteKit
import GameplayKit

public class PlayingState: GKState {
    public unowned let scene : BedroomScene
    
    public init(scene: SKScene) {
        self.scene = scene as! BedroomScene
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        scene.gameLayer?.configureLayer()
        
    }
    
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
}
