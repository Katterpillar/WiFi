//
//  FaoritesCDStack.swift
//  Wi-Fi_Map
//
//  Created by Katherine on 27/11/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

/// класс, работающий с core data, для сохранения избранного
internal final class FavoritesCDStack {
    
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
    
    /// функция сохранения в список избранного 
    func save(location: WiFiEntity) {
        
        persistentContainer.performBackgroundTask { (context) in
            //создаем новый  managed-object
            let savedData = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
            savedData.setValue(location.id, forKey: "id")
            savedData.setValue(location.psw, forKey: "psw")
            savedData.setValue(location.city, forKey: "city")
            savedData.setValue(location.adress, forKey: "adress")
            do {
                try context.save()
                print("Succesful Favorites")
            } catch {
                print("WTF")
            }
            
        }
    }
    
    func deleteItem(adress: String){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        request.predicate = NSPredicate(format: "adress CONTAINS[c] %@", adress)
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
