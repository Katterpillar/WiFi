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
    
    /// загружает данные по точкам из coredata
    func loadFromCoreData() {
        do {
            try fetchResultController.performFetch()
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
