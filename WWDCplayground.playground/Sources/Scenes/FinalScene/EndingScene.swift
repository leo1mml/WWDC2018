import SpriteKit
import GameplayKit

public class EndingScene: SKScene{
    
    public var switchSceneDelegate : SwitchScenesProtocol?
    var introLabel: SKLabelNode?
    
    public override init(size: CGSize) {
        super.init(size: size)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func didMove(to view: SKView) {
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
            labelNode.text = "Congratulations!"
        }
        let changeText2 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "You made him very happy!"
        }
        let changeText3 = SKAction.customAction(withDuration: 0) { (label, float) in
            let labelNode = label as! SKLabelNode
            labelNode.text = "The end"
        }
        
        
        let sequence = SKAction.sequence([changeText1, showText, fadeText, changeText2, showText, fadeText, changeText3, showText])
        self.introLabel?.run(sequence) {
            self.switchSceneDelegate?.goToBedroom()
        }
    }
    
}
