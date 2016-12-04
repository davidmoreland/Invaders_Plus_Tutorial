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
    var settings : Settings = Settings()
    var numberOfShotsText : String = "1"
  //  let settings.SettingsVC = self
    
    
    
    
// Invaders -- Number of Shots On screen
    @IBOutlet weak var Invader_NumberOfShotsLabel: UILabel!
    
    
    
    @IBOutlet weak var Invader_NumberOfShotsStepper: UIStepper!
      @IBAction func Invader_NumberOfShotsStepper(_ sender: UIStepper) {
        
        let invaderNumberOfShots = "\(Int(sender.value))"
        
        Invader_NumberOfShotsLabel.text = invaderNumberOfShots
        settings.invaderNumberOfShots = invaderNumberOfShots
        
    }
    
    
    
// Invaders -- Firing Rate
    
    @IBOutlet weak var Invader_FiringRateLabel: UILabel!
    @IBOutlet weak var Invader_FiringRateStepper: UIStepper!
    @IBAction func Invader_FiringRateStepper(_ sender: UIStepper) {
        
        let invaderFiringRate = "\(Int(sender.value))"
        
        Invader_FiringRateLabel.text  = invaderFiringRate
        
    settings.invaderFiringRate = invaderFiringRate
        
    }
    
    
    @IBOutlet weak var Invader_ShipSpeedLabel: UILabel!
        

    
    @IBOutlet weak var Invader_ShipSpeedStepper: UIStepper!
    
    @IBAction func Invader_ShipSpeedStepper(_ sender: UIStepper) {
        
        let speed = "\(Int(sender.value))"
        
        Invader_ShipSpeedLabel.text = speed
        
        settings.invaderShipSpeed = speed
        
        let timePerMove = (TimeInterval(sender.value))
        
        settings.invaderTimePerMove = timePerMove
        
      //  gameScene.timePerMove = timePerMove
        
        print("TimePerMove: \(timePerMove)")
        /*
        gameScene.timePerMove = settings.ShipSpeed(time: timePerMove)
        print("GameScene -- TimePerMove: \(gameScene.timePerMove)")
 */   
 }
    
    
    
    
    
 //Defender
    @IBOutlet weak var Defender_NumberOfShotsLabel: UILabel!
    @IBOutlet weak var Defender_NumberOfShotsStepper: UIStepper!
    @IBAction func Defender_NumberOfShotsStepper(_ sender: UIStepper) {
        
        let numberOfShots = "\(Int(sender.value))"
        
         Defender_NumberOfShotsLabel.text = numberOfShots
        
        Defender_NumberOfShotsLabel.text = numberOfShots
        settings.defenderNumberOfShots = numberOfShots
    }
    
    @IBOutlet weak var Defender_FiringRateLabel: UILabel!
    
    @IBOutlet weak var Defender_FiringRateStepper: UIStepper!
    
    @IBAction func Defender_FiringRateStepper(_ sender: UIStepper) {
        let rate = "\(Int(sender.value))"
        Defender_FiringRateLabel.text = rate
        settings.defenderFiringRate = rate
    }
    
    @IBOutlet weak var Defender_ShipSpeedLabel: UILabel!
    
    @IBOutlet weak var Defender_ShipSpeedStepper: UIStepper!
    
    @IBAction func Defender_ShipSpeedStepper(_ sender: UIStepper) {
         let speed = "\(Int(sender.value))"
        Defender_ShipSpeedLabel.text = speed
         settings.defenderShipSpeed = speed
        
       // let timePerMove = (TimeInterval(sender.value))
        
      //  gameScene.timePerMove = timePerMove
     //  gameScene.timePerMove = settings.ShipSpeed(time: timePerMove)
        
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
    
    
    
    @IBOutlet weak var InvaderShip_ReinforcementNumberLabel: UILabel!
    
   
    
    func pauseGame(pause : Bool) {
        
        while pause == true {
            
        }
    }

    @IBAction func exitSettings(_ sender: Any) {
        
        settings.saveGameSettings()
        gameScene.pause = false
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        settings.resetGame()
        gameScene.pause = false
        self.dismiss(animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
     settings.loadGameSettings()
        
        print("loadGameSettings: InvaderShipSpeed \(settings.invaderShipSpeed)")
        self.updateSettingsUILabels()
        self.updateSettingsUISteppers()
    }
    
    
    func exitSettings()
    {
        settings.saveGameSettings()
     //   gameScene.settingsVC = self
        gameScene.pause = false

    }
    
        
        
    

    

    func updateSettingsUILabels() {
    
        //Invader
       
    Invader_ShipSpeedLabel.text = settings.invaderShipSpeed
    Invader_FiringRateLabel.text = settings.invaderFiringRate
    Invader_NumberOfShotsLabel.text = settings.invaderNumberOfShots
        Defender_ShipSpeedLabel.text = settings.defenderShipSpeed
        Defender_FiringRateLabel.text = settings.defenderFiringRate
        Defender_NumberOfShotsLabel.text = settings.defenderNumberOfShots
        
        print("InvaderShipSpeed_Label: \(Invader_ShipSpeedLabel.text)")
        
            
           gameScene.pause = false
        
    }

func updateSettingsUISteppers() {
    
    Invader_ShipSpeedStepper.value = (Double(settings.invaderShipSpeed))!
    Invader_FiringRateStepper.value = (Double(settings.invaderFiringRate))!
    Invader_NumberOfShotsStepper.value = (Double(settings.invaderNumberOfShots))!
    Defender_NumberOfShotsStepper.value = (Double(settings.defenderShipSpeed))!
    Defender_NumberOfShotsStepper.value = (Double(settings.defenderFiringRate))!
    Defender_NumberOfShotsStepper.value = (Double(settings.invaderNumberOfShots))!
    
    
}
    


    
    
}


