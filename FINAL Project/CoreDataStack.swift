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
    
    func refreshData(){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WiFiLock")
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    do
                    {
                        context.delete(result)
                        print("success")
                    }
                }
            }
            try context.save()
        }
        catch { }
    }
    
}
