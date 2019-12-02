//
//  CoreDataStack.swift
//  Wi-Fi_Map
//
//  Created by Katherine on 26/11/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

internal final class CoreDataStack {
    
    static var shared : CoreDataStack {
        let shared = CoreDataStack()
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
    
    func addToCoreData(location: WiFiEntity ){
        
        persistentContainer.performBackgroundTask { (context) in
            //создаем новый  managed-object
            let savedData = NSEntityDescription.insertNewObject(forEntityName: "WiFiLock", into: context)
            savedData.setValue(location.id, forKey: "id")
            savedData.setValue(location.psw, forKey: "psw")
            savedData.setValue(location.city, forKey: "city")
            savedData.setValue(location.adress, forKey: "adress")
            
            do {
                try context.save()
                print("Succesful")
            } catch {
                print("Can't save data")
            }
            
        }
    }
    
    
}
