//
//  AppDelegateTest.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class AppDelegateTest: XCTestCase {

    var reachability: MockReachability!
    
    override func setUp() {
    super.setUp()
     reachability = MockReachability()
    }

    override func tearDown() {
      reachability = nil
    }

    func testThatCheckNetworlChekClassWork() {
        //given
        
        //when

        //than
        
        XCTAssertEqual(reachability.isConnectedToNetworkCallCount, 1)
    }

}
