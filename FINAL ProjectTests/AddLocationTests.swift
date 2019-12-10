//
//  AddLocationTests.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class AddLocationTests: XCTestCase {
    
    var addLocationVC: AddLocationVC!
    var addLocationMockModel: AddLocationViewModelMock!
    var model: AddLocationViewModel!
    
    override func setUp() {
        addLocationMockModel = AddLocationViewModelMock()
        addLocationVC = AddLocationVC(viewModel: addLocationMockModel)
        super.setUp()
    }
    
    override func tearDown() {
        addLocationVC = nil
        super.tearDown()
    }
    
    func testThatChangeAlertMessage() {
        // arrange
        let message = "введите id"
        
        //act
        addLocationVC.viewModel.addLocation()        
        //assert
        XCTAssertEqual(message, addLocationMockModel.alert )
    }
    
    func testThatCheckRefreshingLocation(){
        //arrange
        let locationCheck = WiFiEntity(adress: "Kazarmennaya", city: "Moscow", id:  "id123", psw: "psw", longtitude: "", latitude: "")
        //act
        addLocationVC.viewModel.refreshLocation(addAdressText: "Kazarmennaya", addCityText: "Moscow", addIdText: "id123", addPswText: "psw")
        //assert
        XCTAssertEqual(locationCheck.adress, addLocationMockModel.locationMock.adress)
        XCTAssertEqual(locationCheck.city, addLocationMockModel.locationMock.city)
        XCTAssertEqual(locationCheck.id, addLocationMockModel.locationMock.id)
        XCTAssertEqual(locationCheck.psw, addLocationMockModel.locationMock.psw)
        
    }
    
}
