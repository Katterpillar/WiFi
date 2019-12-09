//
//  WiFiViewService.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
@testable import FINAL_Project

class MockWiFiViewService: WiFiViewService {
    
    var loadListCallCount = 0
    var loadCityListCallCount = 0
    
    override func loadList(){
        loadListCallCount += 1
        }
        
    
    override func loadCityList(){
            loadCityListCallCount += 1
        }
        
    override func chooseCity(with city: String){
            self.cityChange?(city)
        }
        
    override func addToFavorites(_ location: WiFiEntity) {
            self.favoritesCD.save(location: location)
        }
        
    override func searchActivate(with searchBarText: String, and label: String){
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
        
    override func showDetail(with location: WiFiEntity){
            self.setupDetails?(location)
        }
        
    

    
}
