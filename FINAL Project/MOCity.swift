//
//  MOCity.swift
//  FINAL Project
//
//  Created by Katherine on 05/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import  CoreData


@objc(Cities)
internal class Cities: NSManagedObject {
    @NSManaged public var city: String    
}
