//
//  DetailViewModels.swift
//  FINAL Project
//
//  Created by Katherine on 04/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData

class DetailViewModels{
    
    var coredata: FavoritesCDStack
    var model: WiFiModel
    
    init(model: WiFiModel = WiFiModel(), coreDataStack: FavoritesCDStack = FavoritesCDStack.shared) {
        self.model = model
        self.coredata = coreDataStack
    }
    
    func addToFavoritesCoreData(with location: WiFiEntity){
        
    }
    
    
}
