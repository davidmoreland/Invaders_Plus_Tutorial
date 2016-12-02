//
//  Settings.swift
//  Invaders-Plus
//
//  Created by David Moreland on 11/19/16.
//  Copyright © 2016 David Moreland All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    
    var InvaderShipSpeed : String = "1"
    
    var InvaderNumberOfShots : String = "1"
    
    var InvaderFiringRate : String = "1"
    
    var DefenderShipSpeed : String = "1"
    
    var DefenderNumberOfShots : String = "1"
    
    var DefenderFiringRate: String = "1"
    
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
            UserDefaults.standard.setValue("1", forKey: "InvaderShipSpeed")
            
            let invaderShipSpeed = UserDefaults.standard.string(forKey: "InvaderShipSpeed")
            print("Userdefaults - resetGameSettings: InvaderShipSpeed: \(invaderShipSpeed)" )
            
            UserDefaults.standard.setValue("1", forKey: "InvaderNumberOfShots")
            UserDefaults.standard.setValue("1", forKey:  "InvaderFiringRate")
            UserDefaults.standard.setValue("1", forKey:  "DefenderShipSpeed")
            UserDefaults.standard.setValue("1", forKey:  "DefenderNumberOfShots")
            UserDefaults.standard.setValue("1", forKey:  "DefenderFiringRate")
          //  testGameSettings()
            
        }
    }
    
    
        
               
        func loadGameSettingDefaults() {
            
            UserDefaults.standard.string(forKey: "InvaderShipSpeed")
            UserDefaults.standard.string(forKey:  "InvaderNumberOfShots")
            UserDefaults.standard.string(forKey:   "InvaderFiringRate")
            UserDefaults.standard.string(forKey: "DefenderShipSpeed")
            UserDefaults.standard.string(forKey:   "DefenderNumberOfShots")
            UserDefaults.standard.string(forKey:   "DefenderFiringRate")
            
        }
        
            
        }
    



