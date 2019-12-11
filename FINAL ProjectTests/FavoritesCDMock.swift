//
//  FavoritesCDMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

@testable import FINAL_Project

class FavoritesCDMock: FavoritesCDProtocol{

  var  persistentContainer : NSPersistentContainer
    
    var location = WiFiEntity()
    var locationDelete = WiFiEntity()
    var message = ""
    
    func save(location: WiFiEntity) {
        self.location = location
    }
    
    func deleteItem(adress: String) {
        self.locationDelete.adress = adress
        self.message = "удалено"
    }
    
    init(){
        persistentContainer = NSPersistentContainer()
        
    }

    
    
}
