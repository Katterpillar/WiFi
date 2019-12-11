//
//  WiFiModel.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

/// "умная" и самостоятельная модель: ходит в интернет и получает данные, парсит их и записывает в core data
class WiFiModel: WiFiModelProtocol {
    
    private var coreDataStack: CoreDataStack
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    /// подгружает данные в формате JSON из интернета
    internal func loadList(completion: @escaping ([[String]]) -> Void) {
        let urlString = "https://script.google.com/macros/s/AKfycbxTPwuAjoWkqcq-Da9iFCQMkKT90l6m2TTIiNWU0M3GaLl-sUA/exec"
        guard let url  = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let list =  try JSONSerialization.jsonObject(with: data,
                                                             options: .mutableContainers) as? [[String]]
                completion(list ?? [])
            } catch let error{
                print(error)
            }
            
            }.resume()
    }
    
    
    /// обновляет данные в core data при их загрузке из интернета
    internal func refreshCoreData(){
        self.coreDataStack.refreshData()
        self.coreDataStack.refreshCity()
        self.loadList{(list) in
            var cityList = [String]()
            for city in list{
                var location = WiFiEntity()
                location.id = city[0]
                location.psw = city[1]
                location.city = city[2]
                location.adress = city[3]
                location.longtitude = city[4]
                location.latitude = city [5]
                self.coreDataStack.addToCoreData(location: location)
                if cityList.contains(city[2]) {
                    
                } else {
                    cityList.append(city[2])
                    self.coreDataStack.addCityToCoreData(city: cityList[cityList.endIndex - 1])
                }
            }
        }
    }
    
}

