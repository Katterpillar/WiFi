//
//  WiFiViewModel.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

class WiFiViewService: WiFiViewServiceProtocol{
    
    private var coreDataStack: CoreDataStack
    private var favoritesCD: FavoritesCDProtocol
    private var predicate: NSPredicate?
    static let shared = WiFiViewService()
    private var location: WiFiEntity?
    private var model: WiFiModelProtocol
    internal var cities: Set<String>?
    
    internal var dataDidLoad: (() -> ())?
    internal var dataDidChange: (() -> ())?
    internal var cityChange: ((String) -> ())?
    var setupDetails: ((WiFiEntity) -> ())?
    
    
    init(model: WiFiModelProtocol = WiFiModel(), coreDataStack: CoreDataStack = CoreDataStack.shared, favoritesCD: FavoritesCDProtocol = FavoritesCDStack.shared) {
        self.model = WiFiModel()
        self.coreDataStack = coreDataStack
        self.favoritesCD = favoritesCD
        defer{
            self.model = model
        }
    }
    
    internal var fetchResultController : NSFetchedResultsController<WiFiLock> = {
        //fetchRequest — запрос на извлечение объектов NSFetchRequest
        let fetchRequest = NSFetchRequest<WiFiLock>(entityName: "WiFiLock")
        let sortByIndex = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByIndex]
        fetchRequest.fetchBatchSize = 20
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchResultController = NSFetchedResultsController<WiFiLock>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }()
    
    ///загружает данные для их дальнейшего представления
    internal func loadList(){
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        self.dataDidLoad?()
    }
    
    internal var fetchResultCityController : NSFetchedResultsController<Cities> = {
        //fetchRequest — запрос на извлечение объектов NSFetchRequest
        let fetchRequest = NSFetchRequest<Cities>(entityName: "Cities")
        let sortByIndex = NSSortDescriptor(key: "city", ascending: true)
        fetchRequest.sortDescriptors = [sortByIndex]
        fetchRequest.fetchBatchSize = 10
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchResultController = NSFetchedResultsController<Cities>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }()
    
    ///загружает список городов
    internal func loadCityList(){
        do {
            try fetchResultCityController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///осуществляет фильтрацию данных для выбранного города
    internal func chooseCity(with city: String){
        fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", city)
        self.cityChange?(city)
        self.dataDidChange?()
    }
    
    ///добавляет выранную локацию в избранное
    internal func addToFavorites(_ location: WiFiEntity) {
        self.favoritesCD.save(location: location)
    }
    
    ///фильтует представленные данные в зависимости от пользовательского запроса
    internal func searchActivate(with searchBarText: String, and label: String){
        if searchBarText == "" {
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", label)
            self.dataDidChange?()
            
        } else {
            let predicate1 = NSPredicate(format: "city CONTAINS[c] %@", label)
            
            let predicte2 = NSPredicate(format: "adress CONTAINS[c] %@", searchBarText)
            let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: [predicate1,predicte2])
            fetchResultController.fetchRequest.predicate = predicateCompound
            self.dataDidChange?()
        }
        
    }
    
    ///показывает детали точки по выбранному адресу
    internal  func showDetail(with location: WiFiEntity){
        self.setupDetails?(location)
    }
    
}


