//
//  WiFiViewModel.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

class WiFiViewModel {
    
    var coreDataStack: CoreDataStack
    var predicate: NSPredicate?
    
    var model: WiFiModel {
        didSet {
            self.model.dataDidLoad = {
                self.dataDidChange?()
            }
        }
    }
    var dataDidChange: (() -> ())?
    var setupDetails: ((WiFiEntity) -> ())?
    var cities: Set<String>?
    init(model: WiFiModel = WiFiModel(), coreDataStack: CoreDataStack = CoreDataStack.shared) {
        
        self.model = WiFiModel()
        self.coreDataStack = coreDataStack
        defer{
            self.model = model
            self.cities = model.cityList
        }
    }
    
    var fetchResultController : NSFetchedResultsController<WiFiLock> = {
        //fetchRequest — запрос на извлечение объектов NSFetchRequest
        let fetchRequest = NSFetchRequest<WiFiLock>(entityName: "WiFiLock")
        let sortByIndex = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByIndex]
        fetchRequest.fetchBatchSize = 20
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchResultController = NSFetchedResultsController<WiFiLock>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }()
    
    func loadList(){
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        self.dataDidChange?()
    }
    
    func chooseCity(with city: String){
        fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", city)
    }
    
    func pushChoiseVC(){
        //            let vc = ChoiceCityVC()
        //            vc.wifiTableDelegate = self
    }
    
    func searchActivate(with searchBarText: String, and label: String){
        if searchBarText == "" {
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", label)
            
        } else {
            let predicate1 = NSPredicate(format: "city CONTAINS[c] %@", label)
            
            let predicte2 = NSPredicate(format: "adress CONTAINS[c] %@", searchBarText)
            let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: [predicate1,predicte2])
            
            fetchResultController.fetchRequest.predicate = predicateCompound
            
        }
        
    }
    
    func showDetail(with location: WiFiEntity){
        self.setupDetails?(location)
    }
    
}
