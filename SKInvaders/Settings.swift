//
//  Settings.swift
//  Invaders-Plus
//
//  Created by David Moreland on 11/19/16.
//  Copyright © 2016 David Moreland All rights reserved.
//

import UIKit
import SceneKit

class Settings: NSObject {

    var gameScene: GameScene!
    
    let SettingsVC : SettingsVC? = nil
    
    var invaderShipSpeed : String = "1"
    
    var invaderNumberOfShots : String = "1"
    
    var invaderFiringRate : String = "1"
    
    var defenderShipSpeed : String = "1"
    
    var defenderNumberOfShots : String = "1"
    
    var defenderFiringRate: String = "1"
    
    var invaderTimePerMove: TimeInterval = 1.0 {
        didSet {
            print("TimePerMove changed from \(oldValue) to \(invaderTimePerMove)")
            
        
        }
    }
    
    
       
    
    
    // Default
    func EasyGamePlay() {
    
    }
    
    func IntermediateGamePlay() {
        
    }
    
    func AdvancedGamePlay() {
    
    }
    
    func ShipSpeed(time: TimeInterval) -> TimeInterval
    {
        return 1/time
    }
    
    func resetGame() {
        
        resetGameSettings()
    }
    
    
    func resetGameSettings() {
        if UserDefaults.standard.string(forKey: "Invader_ShipSpeed") == nil {
            UserDefaults.standard.setValue(1.0, forKey: "InvaderShipSpeed")
        //    UserDefaults.standard.setValue("1", forKey: "InvaderShipSpeed")
            UserDefaults.standard.setValue("1", forKey: "InvaderNumberOfShots")
            UserDefaults.standard.setValue("1", forKey:  "InvaderFiringRate")
            UserDefaults.standard.setValue("1", forKey:  "DefenderShipSpeed")
            UserDefaults.standard.setValue("1", forKey:  "DefenderNumberOfShots")
            UserDefaults.standard.setValue("1", forKey:  "DefenderFiringRate")
            UserDefaults.standard.setValue(1.0, forKey: "InvaderTimePerMove")
                      
        }
    }
    
    func saveGameSettings() {
        UserDefaults.standard.setValue(self.invaderShipSpeed, forKey: "InvaderShipSpeed")
        UserDefaults.standard.setValue(self.invaderNumberOfShots, forKey: "InvaderNumberOfShots")
        UserDefaults.standard.setValue(self.invaderFiringRate, forKey:  "InvaderFiringRate")
        UserDefaults.standard.setValue(self.defenderShipSpeed, forKey:  "DefenderShipSpeed")
        UserDefaults.standard.setValue(self.defenderNumberOfShots, forKey:  "DefenderNumberOfShots")
        UserDefaults.standard.setValue(self.defenderFiringRate, forKey:  "DefenderFiringRate")
        UserDefaults.standard.setValue(self.invaderTimePerMove, forKey: "InvaderTimePerMove")
        
    }
    
               
        func loadGameSettings() {
            
            self.invaderShipSpeed = UserDefaults.standard.string(forKey: "InvaderShipSpeed")!
            self.invaderTimePerMove = UserDefaults.standard.double(forKey: "InvaderTimePerMove")
            self.invaderNumberOfShots = UserDefaults.standard.string(forKey:  "InvaderNumberOfShots")!
            self.invaderFiringRate = UserDefaults.standard.string(forKey:   "InvaderFiringRate")!
            self.defenderShipSpeed = UserDefaults.standard.string(forKey: "DefenderShipSpeed")!
            self.defenderNumberOfShots = UserDefaults.standard.string(forKey:   "DefenderNumberOfShots")!
            self.defenderFiringRate = UserDefaults.standard.string(forKey:   "DefenderFiringRate")!
            
        }
        
            
        }
    



