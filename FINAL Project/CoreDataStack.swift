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
    
    ///singltone coreData
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
    internal func addToCoreData(location: WiFiEntity ){
        
        persistentContainer.performBackgroundTask { (context) in
            let savedData = NSEntityDescription.insertNewObject(forEntityName: "WiFiLock", into: context)
            savedData.setValue(location.id, forKey: "id")
            savedData.setValue(location.psw, forKey: "psw")
            savedData.setValue(location.city, forKey: "city")
            savedData.setValue(location.adress, forKey: "adress")
            savedData.setValue(location.longtitude, forKey: "longtitude")
            savedData.setValue(location.latitude, forKey: "latitude")
            
            do {
                try context.save()
                print("пользовательская локация успешно сохранена")
            } catch {
                print("невозможно сохранить пользовательскую локацию")
            }
            
        }
    }
    
    /// функция добавления списка городов
    internal func addCityToCoreData(city: String) {
        
        persistentContainer.performBackgroundTask { (context) in
            let savedData = NSEntityDescription.insertNewObject(forEntityName: "Cities", into: context)
            savedData.setValue(city, forKey: "city")
            do {
                try context.save()
                print("новый город сохранен")
            } catch {
                print("не удалось сохранить город")
            }
            
        }
    }
    
    /// очищение core data перед загрузкой новых данных из сети
    internal func refreshData(){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WiFiLock")
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
                        print("обновляем")
                    }
                }
            }
            try context.save()
        }
        catch { }
    }
    
    /// функция очищения списка городов перед обновлением
    internal func refreshCity(){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
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
                        print("обновляем города")
                    }
                }
            }
            try context.save()
        }
        catch { }
    }
    
    /// функция добавления пользовательского города, если он отсутствует в кастомном списке
    internal func addCity(_ city: String){
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
        request.predicate = NSPredicate(format: "city CONTAINS[c] %@", city)
        do
        {
            let results = try context.fetch(request)
            if results.count == 0
            {
                do
                {
                    guard  let entity =  NSEntityDescription.entity(forEntityName: "Cities", in: context) else {
                        return
                    }
                    let testEntity = NSManagedObject(entity: entity, insertInto: context)
                    testEntity.setValue(city, forKey: "city")
                    print("пользовательский город добавлен")
                }
            }
            try context.save()
        }
        catch { }
    }
    
}
