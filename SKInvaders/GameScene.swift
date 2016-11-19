/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  // Private GameScene Properties
    
    // Device Properties
    let motionManager = CMMotionManager()
    
  // Physics Bit Masks
    let kInvaderCategory: UInt32 = 0x1 << 0
    let kShipFiredBulletCategory : UInt32 = 0x1 << 1
    let kShipCategory: UInt32 = 0x1 << 2
    let kSceneEdgeCategory: UInt32 = 0x1 << 3
    let kInvaderFiredBulletCategory: UInt32 = 0x1 << 4
    
    
    // Object Lifecycle Management
    // Enum - Types of Invaders
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
    
    enum BulletType {
        case shipFired
        case invaderFired
    }
    
    let kShipFiredBulletName = "shipFiredBullet"
    let kInvaderFiredBulletName = "invaderFiredBullet"
    let kBulletSize = CGSize(width: 4, height: 8)
    
    // Movement, interactions
    // Inavaders Movements
    enum InvaderMovementDirection {
            case right
            case left
            case downThenRight
            case downThenLeft
            case none
        }
        
// Queue to store info for Update cycles
    var tapQueue = [Int]()
    var contactQueue = [SKPhysicsContact]()
    
    
    
    var contentCreated = false
    
    // 1: Invaders begin by moving to the right.
    var invaderMovementDirection: InvaderMovementDirection = .right
    
    //2:  Invaders haven’t moved yet, so set the time to zero.
    var timeOfLastMove: TimeInterval = 0.0
    
    //3:  Invaders take 1 second for each move. Each step left, right or down takes 1 second.
    let timePerMove: TimeInterval = 1.0
    
    
  
 
// Display Properties
    
    // Invaders
    let kInvaderGridSpacing = CGSize(width: 12, height: 12)
    let kInvaderRowCount = 6
    let kInvaderColCount = 6
    
    // Ship
    let kShipSize = CGSize(width: 30, height: 16)
    let kShipName = "ship"
    
    // Hud
    let kScoreHudName = "scoreHud"
    let kHealthHudName = "helathHud"
    var score: Int = 0
    var shipHealth: Float = 1.0
    
  
    
    
    // Scene Setup and Content Creation
  override func didMove(to view: SKView) {
    
    if (!self.contentCreated) {
      self.createContent()
      self.contentCreated = true

        motionManager.startAccelerometerUpdates()
        physicsWorld.contactDelegate = self
        
          }
    }
 
    
    
  func createContent() {
    
    // place Edge-Loop around Scene
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    
    // Bit Mask
    physicsBody!.categoryBitMask = kSceneEdgeCategory
    
    
    setupInvaders()
    
    setupShip()
    
    setupHud()
    
    
    // black space color
    self.backgroundColor = SKColor.black
  }
  
  
    //// INVADERS creation and Setup
    // create
   func makeInvader(ofType invaderType: InvaderType) -> SKNode {
 
    /*  1:  Declare and set the baseOrigin constant (representing the origin of where to start spawning areas
     – 1/3 from the right of the screen, and 1/2 from the bottom of the screen) and loop over the rows.
 */
    
 var invaderColor: SKColor
        
        switch(invaderType) {
        case .a:
            invaderColor = SKColor.red
        case .b:
            invaderColor = SKColor.green
        case .c:
            invaderColor = SKColor.blue
        }
        
/* Choose a single InvaderType for all invaders in this row based on the row number.
 */
        let invader = SKSpriteNode(color: invaderColor, size: InvaderType.size)
        invader.name = InvaderType.name
    
    // Collision Detection
    invader.physicsBody = SKPhysicsBody(rectangleOf: invader.frame.size)
    invader.physicsBody!.isDynamic = false
    invader.physicsBody!.categoryBitMask = kInvaderCategory
    invader.physicsBody!.contactTestBitMask = 0x0
    invader.physicsBody!.collisionBitMask = 0x0
    
    return invader
    }
    
    
        func setupInvaders() {
        
    //  decides on 'type / color of invader using 'makeInvader'
        let baseOrigin = CGPoint(x: size.width / 3, y: size.height / 3)
        
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
    
// Bullets
    
    func makeBullet(ofType bulletType: BulletType) -> SKNode {
        var bullet: SKNode
        
        switch bulletType {
        case .shipFired:
            bullet = SKSpriteNode(color: SKColor.green, size: kBulletSize)
            bullet.name = kShipFiredBulletName
            
            // Physics
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
            bullet.physicsBody!.isDynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kShipCategory
            bullet.physicsBody!.contactTestBitMask = kInvaderCategory
            bullet.physicsBody!.collisionBitMask = 0x0
            
        case .invaderFired:
                bullet = SKSpriteNode(color: SKColor.magenta, size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
                
                // Physics
                bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
                bullet.physicsBody!.isDynamic = true
                bullet.physicsBody!.affectedByGravity = false
                bullet.physicsBody!.categoryBitMask = kInvaderCategory
                bullet.physicsBody!.contactTestBitMask = kShipCategory
                bullet.physicsBody!.collisionBitMask = 0x0

            break
         }
        
        return bullet
        
        
    }
    

    
        
func moveInvaders(forUpdate currentTime: TimeInterval) {

/*  //1:  If it’s not yet time to move, then exit the method. moveInvaders(forUpdate:) is invoked 60 times per second, but you don’t want the invaders to move that often since the movement would be too fast for a normal person to see.
*/
    // 1
    if (currentTime - timeOfLastMove < timePerMove) {
        
        
        
        return
    }
    
    determineInvaderMovementDirection()
    
/*    //2: Recall that your scene holds all of the invaders as child nodes; you added them to the scene using addChild() in setupInvaders() identifying each invader by its name property. Invoking enumerateChildNodes(withName:using:) only loops over the invaders because they’re named kInvaderName; this makes the loop skip your ship and the HUDs. The guts of the block moves the invaders 10 pixels either right, left or down depending on the value of invaderMovementDirection.
 */
    
 enumerateChildNodes(withName: InvaderType.name) {
        node, stop in
        switch self.invaderMovementDirection {
        case .right:
            node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
        case .left:
            node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
            
        case .downThenLeft, .downThenRight:
            node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
        case .none:
            break
        }
        
/*      //3:  Record that you just moved the invaders, so that the next time this method is invoked (1/60th of a second from now), the invaders won’t move again till the set time period of one second has elapsed.
*/
    
        self.timeOfLastMove = currentTime
    }
    
    
    }
    
    
    
// SETUP Ship
    
    func setupShip() {
/* 1: Create a ship using makeShip(). You can easily reuse makeShip() later if you need to create another ship (e.g. if the current ship gets destroyed by an invader and the player has “lives” left).
*/

        let ship = makeShip()

/* 2: Place the ship on the screen. In Sprite Kit, the origin is at the lower left corner of the screen. The anchorPoint is based on a unit square with (0, 0) at the lower left of the sprite’s area and (1, 1) at its top right. Since SKSpriteNode has a default anchorPoint of (0.5, 0.5), i.e., its center, the ship’s position is the position of its center. Positioning the ship at kShipSize.height / 2.0 means that half of the ship’s height will protrude below its position and half above. If you check the math, you’ll see that the ship’s bottom aligns exactly with the bottom of the scene.
 */
        
        
        ship.position = CGPoint(x: size.width / 2.0, y: kShipSize.height / 2.0)
        addChild(ship)
    }
   
    
    
    func makeShip() -> SKNode {
        let ship = SKSpriteNode(color: SKColor.green, size: kShipSize)
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
        ship.physicsBody!.collisionBitMask = kSceneEdgeCategory
        
        
        return ship
        
        
    }
    
    
    
    // MOVE Ship
    
    func proccessingUserMotion(forUpdate currentTime: TimeInterval) {
       
        // 1: Get the ship from the scene so you can move it.
        
        if let ship = childNode(withName: kShipName) as? SKSpriteNode {
   
/*      //2:  Get the accelerometer data from the motion manager. It is an Optional, that is a variable that can hold either a value or no value. The if let data statement allows to check if there is a value in accelerometerData, if is the case assign it to the constant data in order to use it safely within the if’s scope.
 */
            
            if let data = motionManager.accelerometerData {
               
/*    //3:   If your device is oriented with the screen facing up and the home button at the bottom, then tilting the device to the right produces data.acceleration.x > 0, whereas tilting it to the left produces data.acceleration.x < 0. The check against 0.2 means that the device will be considered perfectly flat/no thrust (technically data.acceleration.x == 0) as long as it's close enough to zero (data.acceleration.x in the range [-0.2, 0.2]). There's nothing special about 0.2, it just seemed to work well for me. Little tricks like this will make your control system more reliable and less frustrating for users.
 */
                

                if fabs(data.acceleration.x) > 0.2 {
                    
                
/* // 4 How fast to move ship.   Hmmm, how do you actually use data.acceleration.x to move the ship? You want small values to move the ship a little and large values to move the ship a lot. For now, you just print out the acceleration value.
*/
                    ship.physicsBody!.applyForce(CGVector(dx: 40 * CGFloat(data.acceleration.x), dy: 0))
                    
                        
                    print("Acceleration X: \(data.acceleration.x)")
                    print("Acceleration Y: \(data.acceleration.y)")
                }
            
            }
        }
    }
    
    
    
    
    
    
    // Make HUD
    func setupHud() {
        //1: Give the score label a name so you can find it later when you need to update the displayed score.
        let scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.name = kScoreHudName
        scoreLabel.fontSize = 25
        
        //2:  Color the score label green.
        scoreLabel.fontColor = SKColor.green
        scoreLabel.text = String(format: "Score: %04u", 0)
        
        //3:  Position the score label.
        scoreLabel.position = CGPoint(x: frame.size.width / 2,
                                      y: frame.height - ( 40 + scoreLabel.frame.size.height / 2))
        addChild(scoreLabel)
        
        
        //4:  Give the health label a name so you can reference it later when you need to update the displayed health.
        let healthLabel = SKLabelNode(fontNamed: "Courier")
        healthLabel.name = kHealthHudName
        healthLabel.fontSize = 25
        
/*     //5:  Color the health label red; the red and green indicators are common colors for these indicators in games, and they’re easy to differentiate in the middle of furious gameplay.
 */
        
 healthLabel.fontColor = SKColor.red
        healthLabel.text = String(format: "Health: %.1f%%", shipHealth * 100)

        //6: Position the health below the score label.
        healthLabel.position = CGPoint( x: frame.size.width / 2,
                                        y: size.height - (80 + healthLabel.frame.size.height / 2))
        addChild(healthLabel)
        
    }
    

    func adjustScore(by points: Int) {
        score += points
        if let score = childNode(withName: kScoreHudName) as? SKLabelNode {
            score.text = String(format: "Score: %04u", self.score)
            
        }
    }
    
    func adjustShipHealth(by healthAdjustment: Float) {
        //1:  
        shipHealth = max(shipHealth + healthAdjustment, 0)
        if let health = childNode(withName: kHealthHudName) as? SKLabelNode {
            health.text = String(format: "Health: %.1f%%", self.shipHealth * 100)
        }
    }
    
    
    
  // Scene Update
  
  override func update(_ currentTime: TimeInterval) {
    /* Called before each frame is rendered */
    
    // Handle Queues
    processContacts(forUpdate: currentTime)
    
    processUerTaps(forUpdate: currentTime)
    
    //Handle Motion
    proccessingUserMotion(forUpdate: currentTime)
    
   moveInvaders(forUpdate: currentTime)
    
    fireInvaderBullets(forUpdate: currentTime)
    
    
  }
    
    
    func processContacts(forUpdate currentTime: TimeInterval) {
        for contact in contactQueue {
            handle(contact)
            
            if let index = contactQueue.index(of: contact) {
                contactQueue.remove(at: index)
            }
        }
    }

    
    
// HELPERS .....
  // Scene Update Helpers
    func processUerTaps(forUpdate currenTime: TimeInterval) {
    //1:  Loop over Queue
        for tapCount in tapQueue {
            if tapCount == 1 {
 
 /*               //2: If the queue entry is a single-tap, handle it. As the developer, you clearly know that you only handle single taps for now, but it’s best to be defensive against the possibility of double-taps (or other actions) later.
*/
                fireShipBullets()
            }
            //3:  Remove used tap from Queue
            tapQueue.remove(at: 0)
        }
        
    }
  
    
    
    
  // Invader Movement Helpers
  
    func determineInvaderMovementDirection() {

/*        //1: Record that you just moved the invaders, so that the next time this method is invoked (1/60th of a second from now), the invaders won’t move again till the set time period of one second has elapsed.
*/
        
        var proposedMovementDirection: InvaderMovementDirection = invaderMovementDirection
        
        //2:  Loop over all the invaders in the scene and invoke the block with the invader as an argument.
        
        enumerateChildNodes(withName: InvaderType.name) {
            node, stop in
            switch self.invaderMovementDirection {
            case .right:
                
/*                //3:  If the invader’s right edge is within 1 point of the right edge of the scene, it’s about to move offscreen. Set proposedMovementDirection so that the invaders move down then left. You compare the invader’s frame (the frame that contains its content in the scene’s coordinate system) with the scene width. Since the scene has an anchorPoint of (0, 0) by default, and is scaled to fill its parent view, this comparison ensures you’re testing against the view’s edges.
*/
                if (node.frame.maxX >= node.scene!.size.width - 1.0) {
                    proposedMovementDirection = .downThenLeft
                    stop.pointee = true
                }
            case .left:
                
                /*  //4:  If the invader’s left edge is within 1 point of the left edge of the scene, it’s about to move offscreen. Set proposedMovementDirection so that invaders move down then right.
                 */
                if (node.frame.minX <= 1.0) {
                    proposedMovementDirection = .downThenRight
                    stop.pointee = true
                }
            case .downThenLeft:
 /*   5:  If invaders are moving down then left, they’ve already moved down at this point, so they should now move left. How this works will become more obvious when you integrate determineInvaderMovementDirection with moveInvadersForUpdate().
 */
                proposedMovementDirection = .left
                stop.pointee = true;
 /*  6:  If the invaders are moving down then right, they’ve already moved down at this point, so they should now move right.
 
 */
                
            case .downThenRight:
                proposedMovementDirection = . right
                stop.pointee = true;
                
            default:
                break
            }
            
        }  // end enumerateChildNode

/*  7: If the proposed invader movement direction is different than the current invader movement direction, update the current direction to the proposed direction.
 */
        
        if (proposedMovementDirection != invaderMovementDirection) {
            invaderMovementDirection = proposedMovementDirection
        }
    }

  // Bullet Helpers
        func fireBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration: TimeInterval, andSOundFileName soundName: String) {
            
 /*       //1:  Create an SKAction that moves the bullet to the desired destination and then removes it from the scene. This sequence executes the individual actions consecutively — the next action only takes place after the previous action has completed. Hence the bullet is removed from the scene only after it has been moved.
 */
            
            
            let bulletAction = SKAction.sequence([SKAction.move(to: destination, duration: duration),
                                                  SKAction.wait(forDuration: 3.0 / 60.0), SKAction.removeFromParent()])
            
/*            //2:  Play the desired sound to signal that the bullet was fired. All sounds are included in the starter project and iOS knows how to find and load them.
  */
            let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
            
/*            //3:  Move the bullet and play the sound at the same time by putting them in the same group. A group runs its actions in parallel, not sequentially.
 */
            
 bullet.run(SKAction.group([bulletAction, soundAction]))
            
            
            //4:  Fire the bullet by adding it to the scene. This makes it appear onscreen and starts the actions.
            addChild(bullet)

        }



 
    func fireShipBullets() {
   let existingBullet = childNode(withName: kShipFiredBulletName)
        
/*        //1: Only fire a bullet if there isn’t one currently on-screen. It’s a laser cannon, not a laser machine gun — it takes time to reload!
*/
        if existingBullet == nil {
        
        if let ship = childNode(withName: kShipName) {
        let bullet = makeBullet(ofType: .shipFired)
    
        //2: Set the bullet’s position so that it comes out of the top of the ship.
        bullet.position = CGPoint(x: ship.position.x,
                                  y: ship.position.y + ship.frame.size.height - bullet.frame.size.height / 2)
        
 /*           //3:  Set the bullet’s destination to be just off the top of the screen. Since the x coordinate is the same as that of the bullet’s position, the bullet will fly straight up.
*/
            
                let bulletDestination = CGPoint( x: ship.position.x,
                                                 y: frame.size.height + bullet.frame.size.height / 2)
            
            //4:  Fire the bullet
                fireBullet(bullet: bullet, toDestination: bulletDestination, withDuration: 1.0, andSOundFileName: "ShipBullet.wav")
                
            
            }
        }
        
        }


    func fireInvaderBullets(forUpdate currentTime: TimeInterval) {
        let existingBullet = childNode(withName: kInvaderFiredBulletName)
        
        //1:  
        if existingBullet == nil {
            var allInvaders = [SKNode]()
            
            //2: 
            enumerateChildNodes(withName: InvaderType.name) {
                node, stop in allInvaders.append(node)
                
            }
            
            if allInvaders.count > 0 {
                //3: 
                
            let allInvadersIndex = Int(arc4random_uniform(UInt32(allInvaders.count)))
                let invader = allInvaders[allInvadersIndex]
                
                
                //4: 
                let bullet = makeBullet(ofType: .invaderFired)
                bullet.position = CGPoint( x: invader.position.x,
                                          y: invader.position.y + bullet.frame.size.height / 2)
                
            
            
            //5:  
            let bulletDestination = CGPoint(x: invader.position.x, y: -(bullet.frame.size.height / 2))
            
            //6:  
            fireBullet(bullet: bullet, toDestination: bulletDestination,
                       withDuration: 2.0, andSOundFileName: "InvaderBullet.wav")
        }
    }
    }



  // User Tap Helpers
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (touch.tapCount == 1) {
            tapQueue.append(1)
            
        }
       }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
        
    }
    
    func handle(_ contact: SKPhysicsContact) {
        //1:  Don't allow same contact twice
        //Ensure you haven't already handled this contact and removed its nodes
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
        let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        
        //2:  Check to see if an invader bullet hits the ship
        if nodeNames.contains(kShipName) && nodeNames.contains(kInvaderFiredBulletName) {
            
            //3:  If invader bullet hit ship then remove ship, bullet and play sound
           // Invader bullet hit a ship
            
            run(SKAction.playSoundFileNamed("ShipHit.wav", waitForCompletion: false))
            
            // 1A: 
            adjustShipHealth(by: -0.334)
            
            if shipHealth <= 0.0 {
                contact.bodyA.node!.removeFromParent()
                contact.bodyB.node!.removeFromParent()

                
            }else {
                if let ship = childNode(withName: kShipName) {
                ship.alpha = CGFloat(shipHealth)
            
                if contact.bodyA.node == ship {
                    contact.bodyB.node!.removeFromParent()
                    
                } else {
                    contact.bodyA.node!.removeFromParent()
                }
            }
        }
        
        
        } else if nodeNames.contains(InvaderType.name) && nodeNames.contains(kShipFiredBulletName) {
            // 4:  
            run(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
            contact.bodyA.node!.removeFromParent()
            contact.bodyB.node!.removeFromParent()
            
            //4A: 
            adjustScore(by: 100)
            }
            
        }
            

    
    
  // HUD Helpers
  
  // Physics Contact Helpers
  
  // Game End Helpers
  

}

