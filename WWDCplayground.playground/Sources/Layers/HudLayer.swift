import SpriteKit

public class HudLayer: SKNode {
    let size : CGSize?
    
    public var messageLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    public var joyLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    var joyBar : SKShapeNode?
    
    
    public init(size: CGSize) {
        self.size = size
        super.init()
        createJoyBar()
        messageLabel.position = CGPoint(x: size.width/2, y: size.height/40)
        messageLabel.fontSize = 16
        messageLabel.text = "Hello, I'm Sir Little Mug"
        self.addChild(messageLabel)
    }
    
    func createJoyBar() {
        self.joyBar = SKShapeNode(rect: CGRect(x: 10, y: (self.size?.height)! * 0.7, width: 32, height: 80))
        self.joyBar?.fillColor = .darkGray
        self.addChild(self.joyBar!)
        self.joyLabel.text = "JOY"
        self.joyLabel.position = CGPoint(x: (self.joyBar?.position.x)! + 22, y: ((self.size?.height)! * 0.7) + 90)
        self.joyLabel.fontSize = 16
        self.addChild(joyLabel)
    }
    
    
    
    func addJoyUnit() {
        switch self.joyBar?.children.count {
        case 0?:
            createJoyUnit(color: UIColor().hexStringToUIColor(hex: "#E54600"), at: CGPoint(x: 10, y: (self.size?.height)! * 0.7))
            break
        case 1?:
            createJoyUnit(color: UIColor().hexStringToUIColor(hex: "#E59E00"), at: CGPoint(x: 10, y: ((self.size?.height)! * 0.7) + 16))
            break
        case 2?:
            createJoyUnit(color: UIColor().hexStringToUIColor(hex: "#E5CE00"), at: CGPoint(x: 10, y: ((self.size?.height)! * 0.7) + 32))
            break
        case 3?:
            createJoyUnit(color: UIColor().hexStringToUIColor(hex: "#B3E500"), at: CGPoint(x: 10, y: ((self.size?.height)! * 0.7) + 48))
            break
        case 4?:
            createJoyUnit(color: UIColor().hexStringToUIColor(hex: "#81E500"), at: CGPoint(x: 10, y: ((self.size?.height)! * 0.7) + 64))
            break
        default:
            break
        }
    }
    func createJoyUnit(color: UIColor, at position: CGPoint){
        let joyUnit = SKShapeNode(rect: CGRect(x: position.x, y: position.y, width: 32, height: 16))
        joyUnit.fillColor = color
        joyUnit.lineWidth = 0.0
        self.joyBar?.addChild(joyUnit)
    }
    
    func increaseJoyUnitsValue() {
        var updatedJoy = UserDefaults.standard.value(forKey: "joyUnits") as! Int
        updatedJoy = updatedJoy + 1
        UserDefaults.standard.set(updatedJoy, forKey: "joyUnits")
    }
    
    func displayMessage(message: String){
        self.messageLabel.text = message
    }
    
    func removeMessage () {
        self.messageLabel.text = ""
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
