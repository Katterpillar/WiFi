//
//  Protocols.swift
//  FINAL Project
//
//  Created by Katherine on 11/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

protocol FavoritesCDProtocol{
    func save(location: WiFiEntity)
    func deleteItem(adress: String)
    var  persistentContainer : NSPersistentContainer {get set}
}


protocol DetailViewControllerDelegate {
    func updateWiFiList(with myData: String)
}

protocol  WiFiViewServiceProtocol {
    func showDetail(with location: WiFiEntity)
    func searchActivate(with searchBarText: String, and label: String)
    func addToFavorites(_ location: WiFiEntity)
    func chooseCity(with city: String)
    func loadList()
    func loadCityList()
    
    var dataDidLoad: (() -> ())? { get set }
    var dataDidChange: (() -> ())? { get set }
    var cityChange: ((String) -> ())? { get set }
    var setupDetails: ((WiFiEntity) -> ())? { get set }
    var fetchResultCityController:  NSFetchedResultsController<Cities> { get set }
    var fetchResultController : NSFetchedResultsController<WiFiLock> {get set}   
    
}
protocol WiFiModelProtocol{
    func loadList(completion: @escaping ([[String]]) -> Void)
    func refreshCoreData()
}

protocol AddLocationServiceProtocol {
    var locationFormData: WiFiEntity { get set }
    func addToCoreData()
}


protocol ReachabilityProtocol{
      func isConnectedToNetwork() -> Bool
}
