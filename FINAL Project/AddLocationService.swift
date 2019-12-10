//
//  AddLocationModel.swift
//  FINAL Project
//
//  Created by Katherine on 02/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation

class AddLocationService {
    
    internal var locationFormData = WiFiEntity()
    private var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    ///добавляет пользовательскую локацию в список точек
    internal func addToCoreData(){
        coreDataStack.addToCoreData(location: locationFormData)
        coreDataStack.addCity(locationFormData.city)
    }
}
