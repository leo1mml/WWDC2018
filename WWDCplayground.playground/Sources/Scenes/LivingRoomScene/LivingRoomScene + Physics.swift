//
//  LivingRoomScene + Physics.swift
//  LittleMug
//
//  Created by Leonel Menezes on 26/03/2018.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import SpriteKit
import GameplayKit

extension LivingRoomScene : SKPhysicsContactDelegate {
    
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
            hitWall()
        }
        if(contactPoint.x < self.size.width * 0.01){
            hitWall()
        }
        if (contactPoint.y < self.size.height * 0.21){
            self.gameLayer?.littleMug?.isJumping = false
        }
        if(contactPoint.x < (self.size.width * 0.0555)){
            checkInteraction(on: contactPoint.x)
        }
    }
    
    public func hitWall() {
        self.gameLayer?.littleMug?.standStill()
    }
}
