//
//  FavoritesViewModels.swift
//  FINAL Project
//
//  Created by Katherine on 04/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

///  view model, осуществляет все операции не касающиеся UI
class FavoritesViewModels {
    
    
    var setupDetails: ((WiFiEntity) -> ())?
    var dataDidChange: (() -> ())?
    static let shared = FavoritesViewModels()
    ///  загружает данные из core data не поднимая все данные, удобно при использовании table view
    var fetchResultController : NSFetchedResultsController<Favorites> = {
        //fetchRequest — запрос на извлечение объектов NSFetchRequest
        let fetchRequest = NSFetchRequest<Favorites>(entityName: "Favorites")
        let sortByIndex = NSSortDescriptor(key: "city", ascending: true)
        fetchRequest.sortDescriptors = [sortByIndex]
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchResultController = NSFetchedResultsController<Favorites>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }()
    
    var cityList : NSFetchedResultsController<Cities> = {
    //fetchRequest — запрос на извлечение объектов NSFetchRequest
    let fetchRequest = NSFetchRequest<Cities>(entityName: "Cities")
    let sortByIndex = NSSortDescriptor(key: "city", ascending: true)
    fetchRequest.sortDescriptors = [sortByIndex]
    let context = CoreDataStack.shared.persistentContainer.viewContext
    let fetchResultController = NSFetchedResultsController<Cities>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
    return fetchResultController
    
    }()
    
    /// загружает данные по точкам из coredata
    func loadFromCoreData() {
        do {
            try fetchResultController.performFetch()
            self.dataDidChange?()
        } catch {
            print(error.localizedDescription)
        }
    }
    /// загружает данные по city из coredata
    func loadCityFromCoreData() {
        do {
            try cityList.performFetch()
            self.dataDidChange?()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// показывает детальную информацию
    ///
    /// - Parameter location: содержит все необходимые пользователю параметры для подключения к сети
    func showDetail(with location: WiFiEntity){
        self.setupDetails?(location)
    }
    
}
