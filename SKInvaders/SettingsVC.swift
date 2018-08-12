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

class SettingsVC: UIViewController {
    
    struct InvaderSettings {
        var numberOfMissles: Int {  willSet { print("Invader-NumberOfMissles NewValue: \(newValue)") } }
        var missleSpeed: Float   {  willSet { print("Invader-MissleSpeed NewValue: \(newValue)") } }
        var firingRate: Float     {  willSet { print("Invader-FiringRate NewValue: \(newValue)") } }
        var shipSpeed: Float     {  willSet { print("NumberOfMissles NewValue: \(newValue)") } }
        var shipDamage: Float    {  willSet { print("NumberOfMissles NewValue: \(newValue)") } }
        var shipRepairTime: Float   {  willSet { print("NumberOfMissles NewValue: \(newValue)") } }
        
        init(numMissles: Int, missleSpeed: Float, firingRate: Float, shipSpeed: Float, shipDamage: Float, shipRepairTime: Float) {
            self.numberOfMissles = numMissles
            self.missleSpeed = missleSpeed
            self.firingRate = firingRate
            self.shipSpeed = shipSpeed
            self.shipDamage = shipDamage
            self.shipRepairTime = shipRepairTime
        }
        
        init() {
            //Default Values
            self.numberOfMissles = 3
            self.missleSpeed = 5.0
            self.firingRate = 5.0
            self.shipSpeed = 5.0
            self.shipDamage = 0.0
            self.shipRepairTime = 0.0
        }
        
    }
    
    struct DefenderSettings {
        var numberOfMissles: Int = 5
        var missleSpeed: Float = 5.0
        var firingRate: Float =  5.0
        var shipSpeed: Float = 2.0
        var shipDamage: Float = 0.0
        var shipRepairTime: Float = 1.0
    }
    
    struct GameSettings {
        
    }
    
    
    var pause : Bool = true
    var gameScene : GameScene!
    var GameVC : GameViewController!
   // var settings : Settings = Settings()
    
   // var numberOfShotsText : String = "1"
  //  let settings.SettingsVC = self
    
// MARK: Missle Outlets
    
// Invaders -- Number of Shots On screen
    @IBOutlet weak var Invader_NumShotsLabel: UILabel!
    @IBOutlet var Invader_NumShots_Value: UILabel!
    @IBOutlet weak var Invader_NumberOfShots_Stepper: UIStepper!
    @IBAction func Invader_NumberOfShots_Stepper(_ sender: UIStepper) {
     
    //    let invaderNumberOfShots = "\(Int(sender.value))"
        
    //    Invader_NumberOfShotsLabel.text = invaderNumberOfShots
     //   settings.invaderNumberOfShots = invaderNumberOfShots
        
    }
    
// Invaders -- Missle Firing Rate
    @IBOutlet weak var Invader_FiringRateLabel: UILabel!
    @IBOutlet var Invader_FiringRate_Value: UILabel!
    @IBOutlet weak var Invader_FiringRate_Stepper: UIStepper!
    @IBAction func Invader_FiringRate_Stepper(_ sender: UIStepper) {
    
  //  let invaderFiringRate = "\(Int(sender.value))"
        
     //   Invader_FiringRateLabel.text  = invaderFiringRate
        
 //   settings.invaderFiringRate = invaderFiringRate
    }
    
//Invader - Missle Speed
    @IBOutlet weak var Invader_MissleSpeedLabel: UILabel!
    @IBOutlet var Invader_MissleSpeed_Value: UILabel!
    @IBOutlet var Invader_MissleSpeed_Stepper: UIStepper!
    @IBAction func Invader_MissleSpeed_Stepper(_ sender: UIStepper) {
        let speed = "\(Int(sender.value))"
        
        Invader_ShipSpeedLabel.text = speed
 //       settings.invaderShipSpeed = speed
        let timePerMove = (TimeInterval(sender.value))
  //      settings.invaderTimePerMove = timePerMove
        print("TimePerMove: \(timePerMove)")
        // should be in 'Settings' not here.
  //      gameScene.timePerMove = settings.ShipSpeed(time: timePerMove)
        print("GameScene -- TimePerMove: \(gameScene.timePerMove)")
 }

//MARK - Invader - Ship
//MARK - Invader Ship Speed
    @IBOutlet var Invader_ShipSpeedLabel: UILabel!
    @IBOutlet var Invader_ShipSpeed_Value: UILabel!
    @IBOutlet weak var Invader_ShipSpeed_Stepper: UIStepper!
    @IBAction func Invader_ShipSpeed_Stepper(_ sender: Any) {
    }
 
//MARK - Invader Ship Damage
    @IBOutlet var Invader_ShipDamageLabel: UILabel!
    @IBOutlet var Invader_ShipDamage_Value: UILabel!
    @IBOutlet var Invader_ShipDamage_Stepper: UIStepper!
    @IBAction func Invader_ShipDamage_Stepper(_ sender: Any) {
    }
   
  // Invader Ship RepairTime
    @IBOutlet var Invader_ShipRepairTimeLabel: UILabel!
    @IBOutlet var Invader_ShipRepairTime_Value: UILabel!
    
    @IBOutlet var Invader_ShipRepairTime_Stepper: UIStepper!
    @IBAction func Invader_ShipRepairTime_Stepper(_ sender: Any) {
    }
    
    
    
    
 //MARK - Defender
    @IBOutlet weak var Defender_NumberOfShotsLabel: UILabel!
    @IBOutlet var Defender_NumOfShots_Value: UILabel!
    @IBOutlet weak var Defender_NumberOfShots_Stepper: UIStepper!
    @IBAction func Defender_NumberOfShots_Stepper(_ sender: UIStepper) {
        
        let numberOfShots = "\(Int(sender.value))"
        
         Defender_NumberOfShotsLabel.text = numberOfShots
        
        Defender_NumberOfShotsLabel.text = numberOfShots
 //       settings.defenderNumberOfShots = numberOfShots
    }
// Defender FiringRate
    @IBOutlet weak var Defender_FiringRateLabel: UILabel!
    @IBOutlet var Defender_FiringRate_Value: UILabel!
    @IBOutlet weak var Defender_FiringRate_Stepper: UIStepper!
    @IBAction func Defender_FiringRate_Stepper(_ sender: UIStepper) {
        let rate = "\(Int(sender.value))"
        Defender_FiringRateLabel.text = rate
  //      settings.defenderFiringRate = rate
    }
    
// Defender Missle Speed
    @IBOutlet var Defender_MissleSpeedLabel: UILabel!
    @IBOutlet var Defender_MissleSpeed_Value: UILabel!
    @IBOutlet var Defender_MissleSpeed_Stepper: UIStepper!
    @IBAction func Defender_MissleSpeed_Stepper(_ sender: Any) {
    }
    
// Defender Ship Speed
    @IBOutlet weak var Defender_ShipSpeedLabel: UILabel!
    @IBOutlet var Defender_ShipSpeed_Value: UILabel!
    @IBOutlet weak var Defender_ShipSpeed_Stepper: UIStepper!
    @IBAction func Defender_ShipSpeed_Stepper(_ sender: UIStepper) {
         let speed = "\(Int(sender.value))"
        Defender_ShipSpeedLabel.text = speed
 //        settings.defenderShipSpeed = speed
        
       // let timePerMove = (TimeInterval(sender.value))
        
      //  gameScene.timePerMove = timePerMove
     //  gameScene.timePerMove = settings.ShipSpeed(time: timePerMove)
        
    }

// MARK - Defender Ship Damage
    @IBOutlet weak var Defender_ShipDamageLabel: UILabel!
    @IBOutlet var Defender_ShipDamage_Value: UILabel!
    @IBOutlet var Defender_ShipDamage_Stepper: UIStepper!
    @IBAction func Defender_ShipDamage_Stepper(_ sender: Any) {
    }
    
//Defender - Ship RepairTime
    @IBOutlet var Defender_ShipRepairTimeLabel: UILabel!
    @IBOutlet var Defender_ShipRepairTime_Value: UILabel!
    @IBOutlet var Defender_ShipRepairTime_Stepper: UIStepper!
    @IBAction func Defender_ShipRepairTime_Stepper(_ sender: Any) {
    }
    
    
    // MARK - Game Level Settings
    @IBOutlet weak var InvaderMissles_MaxNumberLabel: UILabel!
    @IBOutlet weak var InvaderMissles_MaxNumber: UIStepper!
    
    @IBAction func MaxNumberOfMissles(_ sender: UIStepper) {
        
        InvaderMissles_MaxNumberLabel.text = "\(Int(sender.value))"
    }
    
    @IBOutlet weak var MaxNumberOfShipsLabel: UILabel!
    
    // Ships
    @IBOutlet weak var InvaderShip_InitialNumberLabel: UILabel!
    
    
    func updateInvaderSettingsFor(name: UIStepper) {
        
        switch name {
        case Invader_MissleSpeed_Stepper:
            print("Case: UpdateInvader - MissleSpeed")
        case Invader_ShipSpeed_Stepper:
            print("Case: UpdateInvader - ShipSpeed")
        case Invader_FiringRate_Stepper:
            print("Case: UpdateInvader - FiringRate")
        default:
            print("Case: Default")
        }
       
    }
   
    
    
    
  
   
    
    func pauseGame(pause : Bool) {
        
        while pause == true {
            
        }
    }

    @IBAction func exitSettings(_ sender: Any) {
        
   //     settings.saveGameSettings()
        gameScene.pause = false
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
     //   settings.resetGame()
        gameScene.pause = false
        self.dismiss(animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
    // settings.loadGameSettings()
        gameScene.pause = true
        
    //    print("loadGameSettings: InvaderShipSpeed \(settings.invaderShipSpeed)")
        self.updateSettingsUILabels()
        self.updateSettingsUISteppers()
    }
    
   /*
    func exitSettings()
    {
        settings.saveGameSettings()
     //   gameScene.settingsVC = self
        gameScene.pause = false

    }
    */
        
        
    

    

    func updateSettingsUILabels() {
    
        //Invader
   /*
    Invader_ShipSpeedLabel.text = settings.invaderShipSpeed
    Invader_FiringRateLabel.text = settings.invaderFiringRate
    Invader_NumberOfShotsLabel.text = settings.invaderNumberOfShots
        Defender_ShipSpeedLabel.text = settings.defenderShipSpeed
        Defender_FiringRateLabel.text = settings.defenderFiringRate
        Defender_NumberOfShotsLabel.text = settings.defenderNumberOfShots
      */
    //    print("InvaderShipSpeed_Label: \(Invader_ShipSpeedLabel.text)")
        
            
           gameScene.pause = false
        
    }

func updateSettingsUISteppers() {
  /*
    Invader_ShipSpeedStepper.value = (Double(settings.invaderShipSpeed))!
    Invader_FiringRateStepper.value = (Double(settings.invaderFiringRate))!
    Invader_NumberOfShotsStepper.value = (Double(settings.invaderNumberOfShots))!
    Defender_NumberOfShotsStepper.value = (Double(settings.defenderShipSpeed))!
    Defender_NumberOfShotsStepper.value = (Double(settings.defenderFiringRate))!
    Defender_NumberOfShotsStepper.value = (Double(settings.invaderNumberOfShots))!
 */
    
}
    


    
    
}


