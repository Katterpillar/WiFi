//
//  WiFiModel.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

class WiFiModel{
    
    var coreDataStack: CoreDataStack
    var viewModel: WiFiViewModel
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared, viewModel: WiFiViewModel = WiFiViewModel()) {
        self.coreDataStack = coreDataStack
        self.viewModel = viewModel
    }
    
    func loadList(completion: @escaping ([[String]]) -> Void) {
        let urlString = "https://script.google.com/macros/s/AKfycbxTPwuAjoWkqcq-Da9iFCQMkKT90l6m2TTIiNWU0M3GaLl-sUA/exec"
        guard let url  = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let list =  try JSONSerialization.jsonObject(with: data,
                                                             options: .mutableContainers) as? [[String]]
                completion(list ?? [])
                print(list)
            } catch let error{
                print(error)
            }
            
            }.resume()
    }
    
    func addToCoreData(){
        coreDataStack.refreshData()
        self.loadList{(list) in
            for i in 0...list.count{
                var location = WiFiEntity()
                location.id = list[i][0]
                location.psw = list[i][1]
                location.city = list[i][2]
                location.adress = list[i][3]
                self.coreDataStack.addToCoreData(location: location)
            }
        }
        viewModel.dataDidChange?()
    }
    

    
}
