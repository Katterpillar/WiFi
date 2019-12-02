//
//  MOLocation.swift
//  Wi-Fi_Map
//
//  Created by Katherine on 26/11/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

@objc(WiFiLock)
internal class WiFiLock: NSManagedObject {
    @NSManaged public var adress: String
    @NSManaged public var id: String
    @NSManaged public var psw: String
    @NSManaged public var city: String
}
