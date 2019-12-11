//
//  WiFiServiceTests.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest
@testable import FINAL_Project

class WiFiServiceTests: XCTestCase {

    var wifiService: WiFiViewService!
    var model : WiFiModelMock!
    var favoritesCD : FavoritesCDMock!
    
    override func setUp() {
        model = WiFiModelMock()
        favoritesCD = FavoritesCDMock()
        wifiService = WiFiViewService(model: model, coreDataStack: CoreDataStack.shared, favoritesCD: favoritesCD )
    super.setUp()
    }

    override func tearDown() {
        wifiService = nil
        model = nil
        favoritesCD = nil
        super.tearDown()
    }

    func testThatCheckAddingRightLocation() {
        //arrange
       let location = WiFiEntity(adress: "Lambada", city: "Guru", id: "Mamkinbandit", psw: "Papinsyn", longtitude: "", latitude: "")
        //act
        wifiService.addToFavorites(location)
        //assert
       assertEqualLocation(actual: location, expected: favoritesCD.location)
    }

    
}
