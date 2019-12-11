//
//  AddLocationModelTests.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class AddLocationModelTests: XCTestCase {
    
    var model = AddLocationMock()
    var viewModel : AddLocationViewModel!
    
    override func setUp() {
        viewModel = AddLocationViewModel(model: model as AddLocationServiceProtocol)
        super.setUp()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testThatChekSavingToCoreData() {
        //assert
        model.locationFormData = WiFiEntity(adress: "Krasnaya", city: "Checoksari", id: "humann", psw: "145sh", longtitude: "", latitude: "")
        //action
        viewModel.addLocation()
        
        //arrange
        XCTAssertEqual("done", model.message)
    }
    
    func testThatCheckIdMessage(){
        //assert
        model.locationFormData = WiFiEntity(adress: "Krasnaya", city: "Checoksari", id: "", psw: "145sh", longtitude: "", latitude: "")
        //action
        viewModel.addLocation()
        
        //arrange
        XCTAssertEqual("Введите id", viewModel.alertText)
    }
    
    func testThatCheckPswMessage(){
        //assert
        model.locationFormData = WiFiEntity(adress: "Krasnaya", city: "Checoksari", id: "humann", psw: "", longtitude: "", latitude: "")
        //action
        viewModel.addLocation()
        
        //arrange
        XCTAssertEqual("Введите пароль", viewModel.alertText)
    }
    
    func testThatCheckAdressMessage(){
        //assert
        model.locationFormData = WiFiEntity(adress: "", city: "Checoksari", id: "humann", psw: "145sh", longtitude: "", latitude: "")
        //action
        viewModel.addLocation()
        
        //arrange
        XCTAssertEqual("Введите адрес", viewModel.alertText)
    }
    
    func testThatCheckCityMessage(){
        //assert
        model.locationFormData = WiFiEntity(adress: "Krasnaya", city: "", id: "humann", psw: "145sh", longtitude: "", latitude: "")
        //action
        viewModel.addLocation()
        
        //arrange
        XCTAssertEqual("Введите город", viewModel.alertText)
    }
    
    func testThatCheckRefreshingText(){
        //assert
        let location = WiFiEntity(adress: "Lambada", city: "Guru", id: "Mamkinbandit", psw: "Papinsyn", longtitude: "", latitude: "")
        //action
        viewModel.refreshLocation(addAdressText: "Lambada", addCityText: "Guru", addIdText: "Mamkinbandit", addPswText: "Papinsyn")
        
        //arrange
        assertEqualLocation(actual: location, expected: model.locationFormData)
    }
}

public func assertEqualLocation(actual: (_: WiFiEntity),
                                expected: (_: WiFiEntity)) {
    if actual.adress != expected.adress ||  actual.id != expected.id || actual.psw != expected.psw || actual.city != expected.city || actual.longtitude != expected.longtitude || actual.latitude != expected.latitude{
        XCTFail("локации не идентичны!")
    }
}
