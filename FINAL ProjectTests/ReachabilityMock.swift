//
//  ReachabilityMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 10/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
@testable import FINAL_Project

class ReachabilityMock: ReachabilityProtocol {
    
    var callCountConnectedToNetwork = 0
    
    func isConnectedToNetwork() -> Bool {
        callCountConnectedToNetwork += 1
        return true
    }
    
}
