//
//  Defender.swift
//  InvadersPlus
//
//  Created by David on 12/2/16.
// Basic Code base: Copyright © 2016 Razeware. All rights reserved.
// See GameScene for details//

import Foundation
import GameKit

class Defender {
    
let kShipName = "ship"
let kShipCategory: UInt32 = 0x1 << 2
    
func makeShip() -> SKNode {
    //   let ship = SKSpriteNode(color: SKColor.green, size: kShipSize)
    
    let ship = SKSpriteNode(imageNamed: "Ship.png")
    ship.name = kShipName
    
    // Physics
    //1:  Create a rectangular physics body the same size as the ship.
    ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
    
    //2: Make the shape dynamic; this makes it subject to things such as collisions and other outside forces.
    ship.physicsBody!.isDynamic = true
    
    /*   3:  You don't want the ship to drop off the bottom of the screen, so you indicate that it's not affected by gravity.
     */
    ship.physicsBody!.affectedByGravity = false
    
    //4: Give the ship an arbitrary mass so that its movement feels natural.
    ship.physicsBody!.mass = 0.02
    
    //collision Detection
    // 1:  Sets Ship Category
    ship.physicsBody!.categoryBitMask = kShipCategory
    
    //2:  Don't detect contact between the ship and other physsics bodies
    ship.physicsBody!.contactTestBitMask = 0x0
    
    //3:  Do detect collisions between the ship and the scene's outer edges
    ship.physicsBody!.collisionBitMask = GameScene().kSceneEdgeCategory
    
    
    return ship
    }
}
