//
//  AddLocationViewModelMock.swift
//  FINAL ProjectTests
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
@testable import FINAL_Project

class AddLocationViewModelMock: AddLocationViewModel{
    
    var alert = String()
   
    var locationMock = WiFiEntity(adress: "", city: "", id: "", psw: "", longtitude: "", latitude: "")
    
    override func addLocation(){
        let adress = "mfkd"
        let city = "dk"
        let id = ""
        let psw = "dsdfn,mcx"
    
        if adress == "" {
          self.alert =  "введите адрес"
        }
        if city == ""{
          self.alert =  "введите город"
        }
        if id == ""{
          self.alert =   "введите id"
        }
        if psw == ""{
           self.alert =  "введите пароль"
    }
    }
    
    override func refreshLocation(addAdressText: String = "", addCityText: String = "", addIdText: String = "", addPswText: String = "") {
        self.locationMock.adress = addAdressText
        self.locationMock.city = addCityText
        self.locationMock.id = addIdText
        self.locationMock.psw = addPswText
    }
    }
