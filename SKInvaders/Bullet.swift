//
//  Bullet.swift
//  InvadersPlus
//
//  Created by David on 12/2/16.
// Basic Code base: Copyright © 2016 Razeware. All rights reserved.
// See GameScene for details
//

import Foundation
import GameKit


class Bullet {
  
    let kShipFiredBulletCategory : UInt32 = 0x1 << 1
    let kSceneEdgeCategory: UInt32 = 0x1 << 3
    let kBulletSize = CGSize(width: 4, height: 8)
    
    let kShipFiredBulletName = "shipFiredBullet"
    let kInvaderFiredBulletName = "invaderFiredBullet"
    
    
    enum BulletType {
        case shipFired
        case invaderFired
    }

    

 func makeBullet(ofType bulletType: BulletType) -> SKNode {
 var bullet: SKNode
 
 switch bulletType {
 case .shipFired:
 bullet = SKSpriteNode(color: SKColor.green, size: kBulletSize)
 bullet.name = kShipFiredBulletName
 
 // Physics
 bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
 bullet.physicsBody!.isDynamic = true
 bullet.physicsBody!.affectedByGravity = true
 bullet.physicsBody!.categoryBitMask = Defender().kShipCategory
 bullet.physicsBody!.contactTestBitMask = Invader().kInvaderCategory
 bullet.physicsBody!.collisionBitMask = 0x0
 
 case .invaderFired:
 bullet = SKSpriteNode(color: SKColor.magenta, size: kBulletSize)
 bullet.name = kInvaderFiredBulletName
 
 // Physics
 bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
 bullet.physicsBody!.isDynamic = true
 bullet.physicsBody!.affectedByGravity = false
 bullet.physicsBody!.categoryBitMask = Invader().kInvaderCategory
 bullet.physicsBody!.contactTestBitMask = Defender().kShipCategory
 bullet.physicsBody!.collisionBitMask = 0x0
 
 break
 }
 
 return bullet
 }
    
    
}

 
