//
//  WiFiVCTest.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class WiFiVCTest: XCTestCase {
    
    var viewModel: MockWiFiViewService!
    var wiFiVC: WiFiVC!
    var cityChoose: ChoiceCityVC!
    var cityResult: String!
    override func setUp() {
        viewModel = MockWiFiViewService()
        wiFiVC = WiFiVC(viewModel: self.viewModel)
        cityChoose = ChoiceCityVC(viewModel: self.viewModel)
        cityResult = String()
        super.setUp()
    }
    
    override func tearDown() {
        viewModel = nil
        wiFiVC = nil
        cityChoose = nil
        cityResult = nil
        super.tearDown()
    }
    
    func testThatCheckThatCityIsRight() {
        //arrange
        let city = "Moscow"
        
        //act
        cityChoose.viewModel.chooseCity(with: city)
        
        //assert
        XCTAssertEqual(cityResult, city)
    }
    
    
    
    
}
