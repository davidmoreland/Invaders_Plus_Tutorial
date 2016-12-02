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
    
    
    var numberOfShotsText : String = "0"
    
    
    
// Invaders -- Number of Shots On screen
    @IBOutlet weak var Invader_NumberOfShotsLabel: UILabel! { willSet(numberOfShotsText) {
        
        }
    }
    
    
    @IBOutlet weak var Invader_NumberOfShotsStepper: UIStepper!
      @IBAction func Invader_NumberOfShotsStepper(_ sender: UIStepper) {
        Invader_NumberOfShotsLabel.text = "\(Int(sender.value))"
        numberOfShotsText = "\(Int(sender.value))"
        
    }
    
    
    
// Invaders -- Firing Rate
    
    @IBOutlet weak var Invader_FiringRateLabel: UILabel!
    @IBOutlet weak var Invader_FiringRateStepper: UIStepper!
    @IBAction func Invader_FiringRateStepper(_ sender: UIStepper) {
        Invader_FiringRateLabel.text  = "\(Int(sender.value))"
    }
    
    
    @IBOutlet weak var Invader_ShipSpeedLabel: UILabel!
    
    @IBOutlet weak var Invader_ShipSpeedStepper: UIStepper!
    
    @IBAction func Invader_ShipSpeedStepper(_ sender: UIStepper) {
        
        Invader_ShipSpeedLabel.text = "\(Int(sender.value))"
        let timePerMove = (TimeInterval(sender.value))
        
        gameScene.timePerMove = timePerMove
        gameScene.timePerMove = settings.ShipSpeed(time: timePerMove)
        
    }
    
    
    
    
    
 //Defender
    @IBOutlet weak var Defender_NumberOfShotsLabel: UILabel!
    @IBOutlet weak var Defender_NumberOfShotsStepper: UIStepper!
    @IBAction func Defender_NumberOfShotsStepper(_ sender: UIStepper) {
        
         Defender_NumberOfShotsLabel.text = "\(Int(sender.value))"
    }
    
    @IBOutlet weak var Defender_FiringRateLabel: UILabel!
    
    @IBOutlet weak var Defender_FiringRateStepper: UIStepper!
    
    @IBAction func Defender_FiringRateStepper(_ sender: UIStepper) {
        Defender_FiringRateLabel.text  = "\(Int(sender.value))"
    }
    
    @IBOutlet weak var Defender_ShipSpeedLabel: UILabel!
    
    @IBOutlet weak var Defender_ShipSpeedStepper: UIStepper!
    
    @IBAction func Defender_ShipSpeedStepper(_ sender: UIStepper) {
        
        Invader_ShipSpeedLabel.text = "\(Int(sender.value))"
        let timePerMove = (TimeInterval(sender.value))
        
        gameScene.timePerMove = timePerMove
        gameScene.timePerMove = settings.ShipSpeed(time: timePerMove)
        
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
        //GameScene.pause = false
        
        self.updateSettings()
         gameScene.settingsVC = self
         self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
     self.reloadSettings()
    }
    
    
    
    func reloadSettings() {
        if (UserDefaults.standard.string(forKey: "InvaderShipSpeed") == nil)
        {
            restoreSettings()
        }
        
        let shipSpeed = UserDefaults.standard.string(forKey: "InvaderShipSpeed")
        
        Invader_ShipSpeedStepper.value = (Double(shipSpeed!))!
        
    }

    
    
    func updateSettings() {
    
        UserDefaults.standard.set(Invader_ShipSpeedLabel.text, forKey: "InvaderShipSpeed")
        
        
        
        print("InvaderShipSpeed: \(UserDefaults.standard.string(forKey: "InvaderShipSpeed"))")
            
   //     settingsData.setValue(InvaderShips_FiringRateLabel.text, forKey: "InvaderFiringRate")
        
        gameScene.pause = false
        
        
        
    }
    
    func restoreSettings()
    {
       
       Invader_ShipSpeedLabel.text = UserDefaults.standard.string(forKey: "InvaderShipSpeed")
      Invader_NumberOfShotsLabel.text =  UserDefaults.standard.string(forKey: "InvaderNumberOfShots")
      Invader_FiringRateLabel.text =   UserDefaults.standard.string(forKey: "InvaderFiringRate")
      Defender_ShipSpeedLabel.text =  UserDefaults.standard.string(forKey: "DefenderShipSpeed")
      Defender_NumberOfShotsLabel.text = UserDefaults.standard.string(forKey: "DefenderNumberOfShots")
      Defender_FiringRateLabel.text =   UserDefaults.standard.string(forKey: "DefenderFiringRate")
        
    }
}
