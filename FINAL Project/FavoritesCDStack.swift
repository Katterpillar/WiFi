//
//  FaoritesCDStack.swift
//  Wi-Fi_Map
//
//  Created by Katherine on 27/11/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

internal final class FavoritesCDStack{
    
    static var shared : FavoritesCDStack {
        let shared = FavoritesCDStack()
        return shared
    }
    
    var  persistentContainer : NSPersistentContainer
    
    init(){
        let group = DispatchGroup()
        
        persistentContainer = NSPersistentContainer(name: "Wi_Fi_Map")
        group.enter()
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error{
                assertionFailure(error.localizedDescription)
            }
            group.leave()
        }
        group.wait()
    }
    
}
