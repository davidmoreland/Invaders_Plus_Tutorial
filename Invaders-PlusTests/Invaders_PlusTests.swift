//
//  Invaders_PlusTests.swift
//  Invaders-PlusTests
//
//  Created by David on 12/1/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import XCTest
@testable import Invaders-Plus.app




class Invaders_PlusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Settings.Settings()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultGameSettings()
    {
        let invaderShipSpeed : String = UserDefaults.standard.string(forKey: "InvaderShipSpeed")!
        let invaderFiringRate : String = UserDefaults.standard.string(forKey: "InvaderFiringRate")!
        let invaderNumberOfShots : String = UserDefaults.standard.string(forKey: "InvaderNumberOfShots")!
        
        XCTAssertEqual(invaderShipSpeed, "1", "Invader Ship Speed should be '1'")
        XCTAssertEqual(invaderFiringRate, "1", "Invader Firing Rate should be '1'")
        XCTAssertEqual(invaderNumberOfShots, "1", "Invader # of shots should be '1'")
        
        print("UserDefaults -- InvaderShipSpeed: \(invaderShipSpeed)")
        print("UserDefaults -- Invader_FiringRate: \(invaderFiringRate)")
        print("UserDefaults -- Invader # of Shots: \(invaderNumberOfShots)")
    }

 func testSettingScreenInitialLoad
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
