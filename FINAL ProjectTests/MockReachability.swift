//
//  ChekNetwork.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import SystemConfiguration

class MockReachability{
    var isConnectedToNetworkCallCount = 0
    
    func isConnectedToNetwork() -> Bool {
        isConnectedToNetworkCallCount += 1
        return true
    }
    
}
