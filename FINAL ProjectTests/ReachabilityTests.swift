//
//  ReachabilityTests.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 10/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class ReachabilityTests: XCTestCase {
    
    var reachability : ReachabilityMock!
    override func setUp() {
        reachability = ReachabilityMock()
        super.setUp()
    }
    
    override func tearDown() {
        reachability = nil
        super.tearDown()
    }
    
    func testExample() {
        //arrange
        var result = Bool()
        //act
        result = reachability.isConnectedToNetwork()
        //assert
        XCTAssertEqual(reachability.callCountConnectedToNetwork, 1)
        XCTAssertEqual(result, true)
    }
    
    
    
}
