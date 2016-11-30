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
    
    var timePerMove : TimeInterval = 1.0
    

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


/*
func setupInvaders() {
    
    //  decides on 'type / color of invader using 'makeInvader'
    let baseOrigin = GameScene.CGPoint(x: size.width / 3, y: size.height / 3)
    
    for row in 0..<kInvaderRowCount {
        
        // 2: Choose a single InvaderType for all invaders in this row based on the row number.
        var invaderType: InvaderType
        
        if row % 3 == 0 {
            invaderType = .a
        } else if row % 3 == 1 {
            invaderType = .b
        } else {
            invaderType = .c
        }
        
        // 3: Do some math to figure out where the first invader in this row should be positioned.
        let invaderPositionY = CGFloat(row) * (InvaderType.size.height * 2) + baseOrigin.y
        
        var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
        
        //4: Loop over the columns.
        for _ in 1..<kInvaderRowCount {
            
            //5: Create an invader for the current row and column and add it to the scene.
            let invader = makeInvader(ofType: invaderType)
            invader.position = invaderPosition
            addChild(invader)
            
            //6: Update the invaderPosition so that it’s correct for the next invader.
            invaderPosition = CGPoint(x: invaderPosition.x + InvaderType.size.width + kInvaderGridSpacing.width,
                                      y:invaderPositionY)
            
        }
    }
}
*/
    
}
