//
//  WiFModelMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
@testable import FINAL_Project

class WiFiModelMock : WiFiModelProtocol{
    
    var callCountRefreshCD = 0
    func loadList(completion: @escaping ([[String]]) -> Void) {
        completion([[""]])
    }
    
    func refreshCoreData() {
        callCountRefreshCD += 1
    }
    
    
}
