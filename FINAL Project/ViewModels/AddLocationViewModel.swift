//
//  AddLocationViewModel.swift
//  FINAL Project
//
//  Created by Katherine on 02/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation

class AddLocationViewModel {
    
    var model: AddLocationService
    var locationFormData: WiFiEntity {
        get {
            return self.model.locationFormData
        }
    }
    
    var showAlert: ( (String) -> () )?
    var formDataDidChange: (() -> ())?
    
    init(model: AddLocationService = AddLocationService()) {
        self.model = model
    }
    
    func addLocation(){
        var filledBad = false
        
        if locationFormData.id == "" {
            filledBad = true
        }
        
        if !filledBad {
            model.addToCoreData()
            refreshLocation()
            formDataDidChange?()
        } else {
            self.showAlert?("Введите айди")
            print("1")
        }
        // FIXME: проверить все поля и показать алерт, если не все поля заполнены
    }
    
    func refreshLocation(addAdressText: String = "", addCityText: String = "", addIdText: String = "", addPswText: String = "") {
        model.locationFormData.adress = addAdressText
        model.locationFormData.city = addCityText
        model.locationFormData.id = addIdText
        model.locationFormData.psw = addPswText
    }
    
}
