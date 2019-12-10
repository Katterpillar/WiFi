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
class FavoritesViewService {
    
    var setupDetails: ((WiFiEntity) -> ())?
    var dataDidChange: (() -> ())?
    var deleteRow:(()->())?
    var favoritesCD: FavoritesCDStack
    static let shared = FavoritesViewService()
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
    internal func loadFromCoreData() {
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
    internal func showDetail(with location: WiFiEntity){
        self.setupDetails?(location)
    }
    
    ///удаляет выбранный элемент
    internal func deleteItem(with location: String){
        favoritesCD.deleteItem(adress: location)
        self.dataDidChange?()
    }
}
