//
//  ModelMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
@testable import FINAL_Project


class AddLocationMock : AddLocationServiceProtocol {
    
    var locationFormData = WiFiEntity()
    var message = ""
    
    
    func addToCoreData() {
        self.message = "done"
    }
   
}
