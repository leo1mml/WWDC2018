import GameplayKit
import SpriteKit

public class IntroState : GKState {
    public unowned let scene : BedroomScene
    
    
    public init(scene: SKScene) {
        self.scene = scene as! BedroomScene
        super.init()
    }
    
    override public func didEnter(from previousState: GKState?) {
        scene.backgroundColor = .black
        scene.stateMachine.enter(PlayingState.self)
    }
    
    override public func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }
}
