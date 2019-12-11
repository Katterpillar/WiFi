//
//  WiFiViewmodelMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData
@testable import FINAL_Project

class WiFiViewServiceMock: WiFiViewServiceProtocol{
    
    var location = WiFiEntity()
    var favorites = WiFiEntity()
    var find = ""
    var label = ""
    var callCountShowDetail = 0
    var callCountSearchActivate = 0
    var callCountAddToFavorites = 0
    var callCountChooseCity = 0
    var callCountLoadList = 0
    var callCountLoadCityList = 0
    
    func showDetail(with location: WiFiEntity) {
        self.location = location
        callCountShowDetail += 1
    }
    
    func searchActivate(with searchBarText: String, and label: String) {
        self.find = "Labu-dabu-dab-dab"
        callCountSearchActivate += 1
    }
    
    func addToFavorites(_ location: WiFiEntity) {
        callCountAddToFavorites += 1
    }
    
    func chooseCity(with city: String) {
        callCountChooseCity += 1
        
    }
    
    func loadList() {
        callCountLoadList += 1
    }
    
    func loadCityList() {
       callCountLoadCityList = 1
    }
    
    var dataDidLoad: (() -> ())?
    
    var dataDidChange: (() -> ())?
    
    var cityChange: ((String) -> ())?
    
    var setupDetails: ((WiFiEntity) -> ())?
    
    var fetchResultCityController: NSFetchedResultsController<Cities> = {
    //fetchRequest — запрос на извлечение объектов NSFetchRequest
    let fetchRequest = NSFetchRequest<Cities>(entityName: "Cities")
    let sortByIndex = NSSortDescriptor(key: "city", ascending: true)
    fetchRequest.sortDescriptors = [sortByIndex]
    fetchRequest.fetchBatchSize = 10
    let context = CoreDataStack.shared.persistentContainer.viewContext
    let fetchResultController = NSFetchedResultsController<Cities>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
    return fetchResultController
    
    }()
    
    var fetchResultController: NSFetchedResultsController<WiFiLock> = {
        //fetchRequest — запрос на извлечение объектов NSFetchRequest
        let fetchRequest = NSFetchRequest<WiFiLock>(entityName: "WiFiLock")
        let sortByIndex = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByIndex]
        fetchRequest.fetchBatchSize = 20
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchResultController = NSFetchedResultsController<WiFiLock>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }()
    
}
