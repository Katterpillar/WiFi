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
    var deleteRow:(()->())?
    var favoritesCD: FavoritesCDStack
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
    
    init(favoritesCD: FavoritesCDStack = FavoritesCDStack.shared) {
        self.favoritesCD = FavoritesCDStack.shared
        defer{
            self.favoritesCD = favoritesCD
        }
    }
    
    /// загружает данные по точкам из coredata
    func loadFromCoreData() {
        do {
            try fetchResultController.performFetch()
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
    
    func deleteItem(with location: String){
        favoritesCD.deleteItem(adress: location)
        self.dataDidChange?()
    }
}
