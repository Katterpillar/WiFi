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
internal final class FavoritesCDStack: FavoritesCDProtocol {
    
    ///singltone coreData
    static var shared : FavoritesCDProtocol {
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
    internal func save(location: WiFiEntity) {
        
        persistentContainer.performBackgroundTask { (context) in
            //создаем новый  managed-object
            let savedData = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
            savedData.setValue(location.id, forKey: "id")
            savedData.setValue(location.psw, forKey: "psw")
            savedData.setValue(location.city, forKey: "city")
            savedData.setValue(location.adress, forKey: "adress")
            savedData.setValue(location.longtitude, forKey: "longtitude")
            savedData.setValue(location.latitude, forKey: "latitude")
            
            do {
                try context.save()
                print("успешно сохранено в избранное")
            } catch {
                print("не удалось сохранить геопозицию")
            }
            
        }
    }
    
    ///удаляет из изранного
    internal func deleteItem(adress: String){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        request.predicate = NSPredicate(format: "adress CONTAINS[c] %@", adress)
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                guard let results = (results as? [NSManagedObject]) else { return }
                for result in results
                {
                    do
                    {
                        context.delete(result)
                        print("удалено из избранного")
                    }
                }
            }
            try context.save()
        }
        catch { }
    }
    
}
