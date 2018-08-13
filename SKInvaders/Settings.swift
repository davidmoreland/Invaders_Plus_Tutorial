//
//  Settings.swift
//  Invaders-Plus
//
//  Created by David Moreland on 11/19/16.
//  Copyright © 2016 David Moreland All rights reserved.
//

import UIKit
import SceneKit
import MapKit
import CoreMotion

class Settings: NSObject {

    struct Map {
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        var latDelta: CLLocationDegrees?
        var lonDelta: CLLocationDegrees?
        var location: CLLocationCoordinate2D?
        var span: MKCoordinateSpan?
        var region: MKCoordinateRegion?
        
        init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, latDelta: CLLocationDegrees, lonDelta: CLLocationDegrees) {
            self.latitude = latitude
            self.longitude = longitude
            self.latDelta = latDelta
            self.lonDelta = lonDelta
            self.location = CLLocationCoordinate2D(latitude: 37.60, longitude: 125.22)
            self.span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            if (location != nil && span != nil) {
                self.region =  MKCoordinateRegion(center: location!, span: span!)
            }
            else if (location == nil) {
                print ("Map Struct: Location Error!!")
            } else if (span == nil) {
                print ("Map Struct: Span Error!!")
            }
        }
        
        init() {
            var latitude: CLLocationDegrees = -137.5252
            var longitude: CLLocationDegrees = 65.0000
            var latDelta: CLLocationDegrees = 10.00
            var lonDelta: CLLocationDegrees = 10.00
            var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            var span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            var region: MKCoordinateRegion?
        }
        
        init(lat: CLLocationDegrees, lon: CLLocationDegrees) {
            self.latitude = lat
            self.longitude = lon
        }
    }
    

    struct Invader {
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
    }
    
    struct Defender {
        var numberOfMissles: Int = 5
        var missleSpeed: Float = 5.0
        var firingRate: Float =  5.0
        var shipSpeed: Float = 2.0
        var shipDamage: Float = 0.0
        var shipRepairTime: Float = 1.0
    }
   
       struct Game {
            struct Device {
                var tiltSensitivity: Double = 1.0
/*                  { {set: }
                    {get: tiltSensitivity}
                    {didSet { print("TiltSensitivity: \(newValue)")}}
 */
            }
        }
 
        struct PlayerStats {
            var name: String!
            var lastGameTime: TimeInterval = 0
            var numDistroyed: Int = 0
            var numMissedShots: Int = 0
            var favoriteLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7648, longitude: -73.9808)  // New York Citlet           var numOfGamesPlayed: Int = 0
            let bestGameTime: TimeInterval = 0
            var highletre: Int = 0
            var totalNumMissedShots: Int = 0
            var totalNumEnemyDistroyed: Int = 0
            
           
        }
    
    
    
    enum Altitude: CLLocationDegrees {
        typealias RawValue = CLLocationDegrees
        
        case outterSpace = 1.00
        case upperAtmoshere = 0.75
        case jetway = 0.50
        case privateAircraft = 0.30
        case low = 0.10
        case treeTop = 0.01
        case ground  = 0.00001
    }
    
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
  /*
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
        
    */

}
    



