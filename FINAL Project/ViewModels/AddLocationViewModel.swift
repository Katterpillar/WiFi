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
    
    private var model: AddLocationServiceProtocol
    internal var locationFormData: WiFiEntity {
        get {
            return self.model.locationFormData
        }
    }
    
   internal var showAlert: ( (String) -> () )?
   internal var formDataDidChange: (() -> ())?
   internal var formDataWillChange: ((UITextView) -> ())?
   internal var alertText: String?
    
    init(model: AddLocationServiceProtocol = AddLocationService()) {
        self.model = model
    }
    
    ///функция добавления локации с проверкой на незаполненные поля
    internal func addLocation(){
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
            alertText = "Введите \(textFildName)"
            self.showAlert?(alertText ?? "Ошибка при вводу данных")
            
        }
    }
    
    ///обновляет данные о локации в текстовом поле
   internal func refreshLocation(addAdressText: String = "", addCityText: String = "", addIdText: String = "", addPswText: String = "") {
        model.locationFormData.adress = addAdressText
        model.locationFormData.city = addCityText
        model.locationFormData.id = addIdText
        model.locationFormData.psw = addPswText
    }
    
    ///обновляет поле ввода(очищает его)
   internal func refreshNilLocation(addAdressText: String = "", addCityText: String = "", addIdText: String = "", addPswText: String = "", textView: UITextView) {
        self.formDataWillChange?(textView)
    }
    
}
