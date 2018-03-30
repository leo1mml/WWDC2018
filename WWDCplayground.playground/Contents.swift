/*: Little Mug - WWDC - The project to make you see yourself always half full
 # Motivation
 This project was inspired by the half full/empty cup dilemma, it basically says that you should give more importance to the little things in life and the things that you have now, because if we spent too much time looking for those things we don't have, we miss the chance to enjoy the most important things in life.
 
 In other words, we have to see our cup always full if possible, or, at least half full.
 
 # Usage Infos
 ## Controls
 You can touch anywhere in the screen to interact with the scene, but you have some rules:
 ### Left Side:
 If you touch anywhere in the left side of the screen, you can move the character with a joystick
 ### Right Side:
 If you touch anywhere in the right side of the screen, your character will check if it can interact with the scene, genereally, if you have a subtitle on the screen, you can interact!
 */


import UIKit
import PlaygroundSupport

let gameViewController = GameViewController(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 667, height: 375)))

PlaygroundPage.current.liveView = gameViewController
PlaygroundPage.current.needsIndefiniteExecution = true
