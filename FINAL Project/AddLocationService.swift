//
//  AddLocationModel.swift
//  FINAL Project
//
//  Created by Katherine on 02/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation

class AddLocationService {
    
    var locationFormData = WiFiEntity()
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
       self.coreDataStack = coreDataStack
        
    }
    
    func addToCoreData(){
       coreDataStack.addToCoreData(location: locationFormData)
    }
}
