import UIKit
import SpriteKit
import AVFoundation

public protocol SwitchScenesProtocol {
    func goToBedroom()
    func goToLivingRoom()
    func goOutside()
}

public class GameViewController: SKView, SwitchScenesProtocol {
    
    public var introScene: IntroScene?
    public var bedroomScene: BedroomScene?
    public var livingRoomScene: LivingRoomScene?
    public var outsideScene: OutsideScene?
    var backgroundMusic : AVAudioPlayer?
    var hasBeganToPlay = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
        
        self.introScene = IntroScene(size: self.frame.size)
        self.introScene?.switchSceneDelegate = self
        
        self.bedroomScene = BedroomScene(size: self.frame.size, stateClass: IntroState.self, joyUnits: 0, mugPosition: CGPoint(x: (self.frame.size.width)/7, y: (self.frame.size.height) * 0.3467))
        self.bedroomScene?.callSceneDelegate = self
        
        self.livingRoomScene = LivingRoomScene(size: self.frame.size)
        self.livingRoomScene?.switchSceneDelegate = self
        
        self.outsideScene = OutsideScene(size: self.frame.size)
        self.outsideScene?.switchSceneDelegate = self
        
        bedroomScene?.scaleMode = .aspectFit
        introScene?.scaleMode = .aspectFit
        livingRoomScene?.scaleMode = .aspectFit

        UserDefaults.standard.set(0, forKey: "joyUnits")
        
        self.presentScene(self.introScene!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func goToBedroom() {
        if !self.hasBeganToPlay {
            do{
                self.backgroundMusic =  try AVAudioPlayer(contentsOf:URL.init(fileURLWithPath: Bundle.main.path(forResource: "Splashing_Around", ofType: "mp3")!))
                self.backgroundMusic?.numberOfLoops = -1
                self.backgroundMusic?.play()
                self.hasBeganToPlay = true
            }catch{
                print(error)
            }
        }
        self.presentScene(self.bedroomScene!)
    }

    public func goToLivingRoom() {
        self.presentScene(self.livingRoomScene!)
    }

    public func goOutside() {
        self.presentScene(self.outsideScene!)
    }
}
