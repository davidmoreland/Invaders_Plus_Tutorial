//
//  Invaders_PlusTests.swift
//  Invaders-PlusTests
//
//  Created by David on 12/1/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import XCTest

@testable import InvadersPlus




class Invaders_PlusTests: XCTestCase {
    
    
    let settings = Settings()
    let settingsVC = SettingsViewController()
    
    override func setUp() {
        super.setUp()
        
        printBlankLines()
       
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
         printBlankLines()
    }
    
// Test Helpers
    func printBlankLines() {
        print("\n\n")
        
    }
    
  // Settings()
    func testDefaultGameSettings()
    {
        
        settings.resetGame()
        
        let invaderShipSpeed : String = UserDefaults.standard.string(forKey: "InvaderShipSpeed")!
        let invaderFiringRate : String = UserDefaults.standard.string(forKey: "InvaderFiringRate")!
        let invaderNumberOfShots : String = UserDefaults.standard.string(forKey: "InvaderNumberOfShots")!
        let defenderShipSpeed : String = UserDefaults.standard.string(forKey: "DefenderShipSpeed")!
        let defenderFiringRate : String = UserDefaults.standard.string(forKey: "DefenderFiringRate")!
        let defenderNumberOfShots : String = UserDefaults.standard.string(forKey: "DefenderNumberOfShots")!
        
        
        
        XCTAssertEqual(invaderShipSpeed, "1", "Invader Ship Speed should be '1'")
        XCTAssertEqual(invaderFiringRate, "1", "Invader Firing Rate should be '1'")
        XCTAssertEqual(invaderNumberOfShots, "1", "Invader # of shots should be '1'")
        XCTAssertEqual(defenderShipSpeed, "1", "Defender Ship Speed should be '1'")
        XCTAssertEqual(defenderFiringRate, "1", "Defender Firing Rate should be '1'")
        XCTAssertEqual(defenderNumberOfShots, "1", "Defender # of shots should be '1'")
        
        
        print("Test: settings.resetGame: Default Settings (1) ")
            print("UserDefaults -- InvaderShipSpeed: \(invaderShipSpeed)")
        print("UserDefaults -- InvaderFiringRate: \(invaderFiringRate)")
        print("UserDefaults -- Invader # of Shots: \(invaderNumberOfShots)")
        print("UserDefaults -- DefenderShipSpeed: \(defenderShipSpeed)")
        print("UserDefaults -- DefenderFiringRate: \(defenderFiringRate)")
        print("UserDefaults -- Defender # of Shots: \(defenderNumberOfShots)")
    }

    // SETTINGS
    func testSaveGameSettings() {
        //Test Data
        settings.defenderFiringRate = "10"
        settings.defenderNumberOfShots = "10"
        settings.defenderShipSpeed = "10"
        settings.invaderFiringRate = "10"
        settings.invaderNumberOfShots = "10"
        settings.invaderShipSpeed = "10"
   // Test Function
        settings.saveGameSettings()
        
        
        // Test Run
        let invaderShipSpeed : String = UserDefaults.standard.string(forKey: "InvaderShipSpeed")!
        let invaderFiringRate : String = UserDefaults.standard.string(forKey: "InvaderFiringRate")!
        let invaderNumberOfShots : String = UserDefaults.standard.string(forKey: "InvaderNumberOfShots")!
        let defenderShipSpeed : String = UserDefaults.standard.string(forKey: "DefenderShipSpeed")!
        let defenderFiringRate : String = UserDefaults.standard.string(forKey: "DefenderFiringRate")!
        let defenderNumberOfShots : String = UserDefaults.standard.string(forKey: "DefenderNumberOfShots")!

        
        
        XCTAssertEqual(invaderShipSpeed, "10", "Invader Ship Speed should be '10'")
        XCTAssertEqual(invaderFiringRate, "10", "Invader Firing Rate should be '10'")
        XCTAssertEqual(invaderNumberOfShots, "10", "Invader # of shots should be '10'")
        XCTAssertEqual(defenderShipSpeed, "10", "Defender Ship Speed should be '10'")
        XCTAssertEqual(defenderFiringRate, "10", "Defender Firing Rate should be '10'")
        XCTAssertEqual(defenderNumberOfShots, "10", "Defender # of shots should be '10'")
        
        
        
        print("Test: Settings.saveGameSettings (10) ")
            print("UserDefaults -- InvaderShipSpeed: \(invaderShipSpeed)")
        print("UserDefaults -- InvaderFiringRate: \(invaderFiringRate)")
        print("UserDefaults -- Invader # of Shots: \(invaderNumberOfShots)")
        print("UserDefaults -- DefenderShipSpeed: \(defenderShipSpeed)")
        print("UserDefaults -- DefenderFiringRate: \(defenderFiringRate)")
        print("UserDefaults -- Defender # of Shots: \(defenderNumberOfShots)")

        
    }
    
    func testLoadGameSettings() {
        testSaveGameSettings()
        
        settings.loadGameSettings()
        
        let invaderShipSpeed : String = UserDefaults.standard.string(forKey: "InvaderShipSpeed")!
        let invaderFiringRate : String = UserDefaults.standard.string(forKey: "InvaderFiringRate")!
        let invaderNumberOfShots : String = UserDefaults.standard.string(forKey: "InvaderNumberOfShots")!
        let defenderShipSpeed : String = UserDefaults.standard.string(forKey: "DefenderShipSpeed")!
        let defenderFiringRate : String = UserDefaults.standard.string(forKey: "DefenderFiringRate")!
        let defenderNumberOfShots : String = UserDefaults.standard.string(forKey: "DefenderNumberOfShots")!

        XCTAssertEqual(settings.invaderShipSpeed, invaderShipSpeed, "Invader Ship Speed should be '10'")
        XCTAssertEqual(settings.invaderFiringRate, invaderFiringRate, "Invader Firing Rate should be '10'")
        XCTAssertEqual(settings.invaderNumberOfShots, invaderNumberOfShots, "Invader # of shots should be '10'")
        XCTAssertEqual(settings.defenderShipSpeed, defenderShipSpeed, "Defender Ship Speed should be '10'")
        XCTAssertEqual(settings.defenderFiringRate, defenderFiringRate, "Defender Firing Rate should be '10'")
        XCTAssertEqual(settings.defenderNumberOfShots, defenderNumberOfShots, "Defender # of shots should be '10'")
        
        
        
        
    }
  
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
