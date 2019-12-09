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

    override func setUp() {
        addLocationVC = AddLocationVC(viewModel: AddLocationViewModelMock())
        addLocationMockModel = AddLocationViewModelMock()
        super.setUp()
    }

    override func tearDown() {
       addLocationVC = nil
       super.tearDown()
    }

    func testThatChangeAlertMessage() {
        // arrange
        var realmessage = ""
        
        //act
        addLocationMockModel.addLocation(adress: "Smth", city: "LA", id: "", psw: "1234ffu")
        realmessage = addLocationMockModel.showAllert(state: true, textView: "id")
        //assert
        XCTAssertEqual(addLocationMockModel.alert, realmessage)
    }


}
