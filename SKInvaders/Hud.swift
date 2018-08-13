//
//  Hud.swift
//  InvadersPlus
//
//  Created by David on 12/8/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import GameKit

class Hud {
    
    let kHudCategory : UInt32 = 0x1 << 0
    
    let kHudName :String = "HudName"
    
    
    func makeHud() -> SKNode {
        
        let hud = SKSpriteNode(color: UIColor.lightGray.withAlphaComponent(0.2), size: CGSize(width: 200.0, height: 25.0))
        hud.name = kHudName
        
        // Physics
        //1:  Create a rectangular physics body the same size as the ship.
        hud.physicsBody = SKPhysicsBody(rectangleOf: hud.frame.size)
        
        //2: Make the shape dynamic; this makes it subject to things such as collisions and other outside forces.
        hud.physicsBody!.isDynamic = false
        
        /*   3:  You don't want the ship to drop off the bottom of the screen, so you indicate that it's not affected by gravity.
         */
        hud.physicsBody!.affectedByGravity = false
        
        //4: Give the ship an arbitrary mass so that its movement feels natural.
        hud.physicsBody!.mass = 0.0
        
        //collision Detection
        // 1:  Sets Ship Category
        hud.physicsBody!.categoryBitMask = self.kHudCategory
        
        //2:  Don't detect contact between the ship and other physsics bodies
        hud.physicsBody!.contactTestBitMask = 0x0
        
        //3:  Do detect collisions between the ship and the scene's outer edges
   //     hud.physicsBody!.collisionBitMask =  GameScene().kSceneEdgeCategory
        
        return hud
    }

}
