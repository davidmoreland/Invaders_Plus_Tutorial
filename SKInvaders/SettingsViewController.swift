//
//  SettingsViewController.swift
//  Invaders-Plus
//
//  Created by David on 11/19/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class SettingsViewController: UIViewController {
    
   
    
    var pause : Bool = true
    var gameScene : GameScene!
    var GameVC : GameViewController!

     let settingsData = UserDefaults.standard
    
    
    // Invaders -- Number of Shots On screen
    @IBOutlet weak var Invader_NumberOfShotsLabel: UILabel!
    

    @IBOutlet weak var Invader_NumberOfShots: UIStepper!
    
    

    // Missles
      @IBAction func NumberOfShots(_ sender: UIStepper) {
        Invader_NumberOfShotsLabel.text = "\(Int(sender.value))"
    
        
    }
    
    // Invaders -- Firing Rate
    @IBOutlet weak var Invader_FiringRate: UIStepper!
    

    @IBOutlet weak var InvaderShips_FiringRateLabel: UILabel!
    
    
    
    @IBAction func InvaderFiringRate(_ sender: UIStepper) {
        
        InvaderShips_FiringRateLabel.text  = "\(Int(sender.value))"
    }
    
    
    
    // Screen Missles
    @IBOutlet weak var InvaderMissles_MaxNumberLabel: UILabel!
    
    
    @IBOutlet weak var InvaderMissles_MaxNumber: UIStepper!
    
    
    @IBAction func MaxNumberOfMissles(_ sender: UIStepper) {
        
        InvaderMissles_MaxNumberLabel.text = "\(Int(sender.value))"
        
    }
    
   
    // Cycle Time 'Cannon off-line'
    @IBOutlet weak var ShotCycleTimeLabel: UILabel!
    
    @IBOutlet weak var CannonCycleTime: UIStepper!
    
    
    @IBAction func ShotCycleTimeSetter(_ sender: UIStepper) {
        ShotCycleTimeLabel.text = "\(Int(sender.value))"
    }

    
    @IBOutlet weak var ShieldStrengthLabel: UILabel!
    @IBOutlet weak var NumberOfShipsLabel: UILabel!
    
    // Ships
    @IBOutlet weak var InvaderShip_InitialNumberLabel: UILabel!
    
    @IBOutlet weak var InvaderShipSpeedLabel: UILabel!
    
       
    @IBOutlet weak var InvaderShipSpeed: UIStepper!
    
    @IBAction func InvaderShipSpeed(_ sender: UIStepper) {

     
        
        let speed  = InvaderShipSpeedLabel.text = "\(Int(sender.value))"
        
        self.settingsData.setValue(speed, forKey: "InvaderShipSpeed")
        
        let timePerMove = (TimeInterval(sender.value))
        
        
   //     gameScene.timePerMove = timePerMove
  //  gameScene.timePerMove = Settings().ShipSpeed(time: timePerMove)
    
        }

    
    
    @IBOutlet weak var InvaderShip_ReinforcementNumberLabel: UILabel!
    
    func pauseGame(pause : Bool) {
        
        while pause == true {
            
        }
    }

    @IBAction func exitSettings(_ sender: Any) {
        //GameScene.pause = false
        
        self.updateSettings()
         gameScene.settingsVC = self
         self.dismiss(animated: true, completion: nil)
        
    }
    
    func updateSettings() {
     //   GameScene.timePerMove = (TimeInterval(InvaderShipSpeedLabel.text!))!
        settingsData.setValue(InvaderShipSpeedLabel.text, forKey: "InvaderShipSpeed")
        settingsData.setValue(InvaderShips_FiringRateLabel.text, forKey: "InvaderFiringRate")
        
        gameScene.pause = false
        
        
        
    }
    
    func restoreSettings()
    {
        InvaderShipSpeedLabel.text = settingsData.string(forKey: "InvaderShipSpeed")
        
    }
}
