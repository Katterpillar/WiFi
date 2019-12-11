//
//  WiFiVCTests.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class WiFiVCTests: XCTestCase {

    var wifiVC : WiFiVC?
    var chooseCityVC : ChoiceCityVC?
    var wifiService: WiFiViewServiceMock?
    override func setUp() {
       wifiService = WiFiViewServiceMock()
        wifiVC = WiFiVC(viewModel: wifiService!)
        chooseCityVC = ChoiceCityVC(viewModel: wifiService!)
        super.setUp()
    }

    override func tearDown() {
        wifiVC = nil
        wifiService = nil
        chooseCityVC = nil
        super.tearDown()
    }

    
    func testThatCheckCallCountListLoad() {
        //arrange
       
        //act
        wifiVC?.viewWillAppear(true)
        //assert
        XCTAssertEqual(1, wifiService?.callCountLoadList)
    }

    func testThatCheckCallCountCityListLoad() {
        //arrange
        //act
        chooseCityVC?.viewDidLoad()
        //assert
        XCTAssertEqual(1, wifiService?.callCountLoadCityList)
    }
    
    func testThatCheckSearchTextAreEqual () {
        //arrange
        let searchBar = wifiVC?.searchBar
        //act
        wifiVC?.searchBar(searchBar!, textDidChange: "Labu-dabu-dab-dab")
        //assert
        XCTAssertEqual("Labu-dabu-dab-dab", wifiService?.find)
    }
    
    func testThatCheckCallCountSearch() {
        //arrange
         let searchBar = wifiVC?.searchBar
        //act
        wifiVC?.searchBar(searchBar!, textDidChange: "Labu-dabu-dab-dab")
        //assert
        XCTAssertEqual(1, wifiService?.callCountSearchActivate)
    }
    
    

    
}
