import SpriteKit
import GameplayKit

public class IntroScene: SKScene{
    
    public var switchSceneDelegate : SwitchScenesProtocol?
    var introLabel: SKLabelNode?
    
    override public init(size: CGSize) {
        super.init(size: size)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func didMove(to view: SKView) {
        self.introLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        self.introLabel?.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.introLabel?.fontSize = 25
        self.introLabel?.numberOfLines = 3
        self.introLabel?.preferredMaxLayoutWidth = view.frame.size.width * 0.8
        self.introLabel?.horizontalAlignmentMode = .center
        self.introLabel?.verticalAlignmentMode = .center
        
        self.addChild(introLabel!)
        let fadeText = SKAction.fadeAlpha(to: 0.0, duration: 2)
        let showText = SKAction.fadeAlpha(to: 1.0, duration: 2)
        let changeText1 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "This is the life of a mug!"
        }
        let changeText5 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "Little Mug"
        }
        let changeText2 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "This mug has always felt half empty"
        }
        let changeText3 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "But you have the chance to change it, now you can help this mug to see himself half full"
        }
        let changeText4 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "You have to find joy in the little things in life"
        }
        let wait = SKAction.wait(forDuration: 2.0)
        
        
        let sequence = SKAction.sequence([changeText1, showText, fadeText, changeText2, showText, fadeText, changeText3, showText, wait, fadeText, changeText4, showText, wait, fadeText, changeText5, showText])
        self.introLabel?.run(sequence) {
            self.switchSceneDelegate?.goToBedroom()
        }
    }

}
