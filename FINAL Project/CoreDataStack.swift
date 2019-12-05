//
//  CoreDataStack.swift
//  Wi-Fi_Map
//
//  Created by Katherine on 26/11/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData
/// класс, реализущий основную работу с Core data в приложении
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
    
    ///  функция добавления Данных о вай-фай точках в core data
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
    
    /// функция добавления списка городов
    func addCityToCoreData(city: String) {
        
        persistentContainer.performBackgroundTask { (context) in
            let savedData = NSEntityDescription.insertNewObject(forEntityName: "Cities", into: context)
            savedData.setValue(city, forKey: "city")
            do {
                try context.save()
                print("SuccesfulCity")
            } catch {
                print("Can't save data")
            }
            
        }
    }
    
    /// очищение core data перед загрузкой новых данных из сети
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
    
    
    /// функция очищения списка городов перед обновлением
    func refreshCity(){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
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
