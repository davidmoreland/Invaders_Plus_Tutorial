//
//  Invader.swift
//  Invaders-Plus
//
//  Created by David on 11/23/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import GameKit

class Invader {

  //  var settings = Settings()
  //  var timeValue = (TimeInterval(UserDefaults.standard.string(forKey:"InvaderShipSpeed")!))
    
    
    let kInvaderCategory: UInt32 = 0x1 << 0

    var timePerMove = 1.0
   // var timePerMove  = settings.ShipSpeed(timeValue)

enum InvaderType {
    case a
    case b
    case c
    
    static var size: CGSize {
        return CGSize(width: 24, height: 24)
    }
    static var name: String {
        return "invader"
    }
}


// Textures
func loadInvaderTextures(ofType invaderType: InvaderType)->[SKTexture] {
    
    var prefix: String
    switch(invaderType) {
    case .a:
        prefix = "InvaderA"
    case .b:
        prefix = "InvaderB"
    case .c:
        prefix = "InvaderC"
        
    }
    
    // Loads a pair of sprite images — InvaderA_00.png and InvaderA_01.png — for each invader type and creates SKTexture objects from them.
    return [SKTexture(imageNamed: String(format:"%@_00.png", prefix)),
            SKTexture(imageNamed: String(format: "%@_01.png", prefix))]
    
}

    




func makeInvader(ofType invaderType: InvaderType)-> SKNode {
    
    let invaderTextures = loadInvaderTextures(ofType: invaderType)
    
    // Uses the first such texture as the sprite’s base image.
    let invader = SKSpriteNode(texture: invaderTextures[0])
    invader.name = InvaderType.name
  
    // Animates these two images in a continuous animation loop.
    invader.run(SKAction.repeatForever(SKAction.animate(with: invaderTextures, timePerFrame: timePerMove)))
    
    
    //invaders' bitmasks setup
    invader.physicsBody = SKPhysicsBody( rectangleOf: invader.frame.size)
    invader.physicsBody!.isDynamic = false
    invader.physicsBody!.categoryBitMask = kInvaderCategory
    invader.physicsBody!.contactTestBitMask = 0x0
    invader.physicsBody!.collisionBitMask = 0x0
    return invader
}


    
}
