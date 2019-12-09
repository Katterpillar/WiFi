//
//  AddLocationViewModelMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
@testable import FINAL_Project

class AddLocationViewModelMock: AddLocationViewModel {
    
    var alert = String()
   
    func showAllert(state: Bool, textView: String) -> String{
        if state {
            alert = "введите \(textView)"
        } else {
            alert = "добавлено"
        }
        return alert
    }
    
     func addLocation(adress: String, city: String, id: String, psw: String){
        let adress = adress
        let city = city
        let id = id
        let psw = psw
    
        if adress == "" {
            alert = "введите адрес"
        }
        if city == ""{
           alert = "введите город"
        }
        if id == ""{
            alert = "введите id"
        }
        if psw == ""{
        alert = "введите пароль"
    }
}
}
