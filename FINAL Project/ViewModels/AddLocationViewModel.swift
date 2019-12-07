//
//  AddLocationViewModel.swift
//  FINAL Project
//
//  Created by Katherine on 02/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

class AddLocationViewModel {
    
    var model: AddLocationService
    var locationFormData: WiFiEntity {
        get {
            return self.model.locationFormData
        }
    }
    
    var showAlert: ( (String) -> () )?
    var formDataDidChange: (() -> ())?
    var formDataWillChange: ((UITextView) -> ())?
    
    init(model: AddLocationService = AddLocationService()) {
        self.model = model
    }
    
    func addLocation(){
        var filledBad = false
        var textFildName = String()
        
        if locationFormData.id == "" {
            filledBad = true
            textFildName = "id"
        }
        if locationFormData.psw == "" {
            filledBad = true
            textFildName = "пароль"
        }
        if locationFormData.adress == "" {
            filledBad = true
            textFildName = "адрес"
        }
        if locationFormData.city == "" {
            filledBad = true
            textFildName = "город"
        }
        if !filledBad {
            model.addToCoreData()
            refreshLocation()
            formDataDidChange?()
        } else {
            self.showAlert?("Введите \(textFildName)")
            
        }
    }
    
    func refreshLocation(addAdressText: String = "", addCityText: String = "", addIdText: String = "", addPswText: String = "") {
        model.locationFormData.adress = addAdressText
        model.locationFormData.city = addCityText
        model.locationFormData.id = addIdText
        model.locationFormData.psw = addPswText
    }
    
    func refreshNilLocation(addAdressText: String = "", addCityText: String = "", addIdText: String = "", addPswText: String = "", textView: UITextView) {
        self.formDataWillChange?(textView)
    }
    
}
