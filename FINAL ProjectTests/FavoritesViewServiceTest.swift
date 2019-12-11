//
//  FavoritesViewServiceTest.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import XCTest

class FavoritesViewServiceTest: XCTestCase {

    var favService: FavoritesViewService!
    var favocritesCD: FavoritesCDMock!
    
    override func setUp() {
        favocritesCD = FavoritesCDMock()
        favService = FavoritesViewService(favoritesCD: favocritesCD)
        super.setUp()
    }

    override func tearDown() {
        favocritesCD = nil
        favService = nil
        super.tearDown()
    }

    func testExample() {
        //arrange
        let location = WiFiEntity(adress: "Lambada", city: "Guru", id: "Mamkinbandit", psw: "Papinsyn", longtitude: "", latitude: "")
        //act
        favService.initDeleteItem(with: location.adress)
        //assert
        XCTAssertEqual(location.adress, favocritesCD.locationDelete.adress)
    }

}
