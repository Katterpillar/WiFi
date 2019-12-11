//
//  AppDelegateTest.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class AppDelegateTest: XCTestCase {

    var appDelegate: AppDelegate!
    var  wifiload : WiFiModelMock!
    var reachability : ReachabilityMock!
    override func setUp() {
        appDelegate = AppDelegate()
        wifiload = WiFiModelMock()
        reachability = ReachabilityMock()
        super.setUp()
    }

    override func tearDown() {
        appDelegate = nil
        wifiload = nil
        reachability = nil
        super.tearDown()
    }

    func testThatCheckCallCountRefreshData() {
        //arrange
        appDelegate.reachability = reachability
        appDelegate.wifiload = wifiload
        //act
        let result = appDelegate.application( UIApplication.shared , didFinishLaunchingWithOptions: nil)
        //assert
        XCTAssertEqual(1, wifiload.callCountRefreshCD )
        XCTAssertEqual(true, result)
    }

    

}
