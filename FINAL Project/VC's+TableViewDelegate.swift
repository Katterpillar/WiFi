//
//  WIFiVC+searchDelegate.swift
//  FINAL Project
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

extension WiFiVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sections = viewService.fetchResultController.sections else {
            fatalError()
        }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError()
        }
        
        var location = WiFiEntity()
        location.id = itemsInSection[indexPath.row].id
        location.psw = itemsInSection[indexPath.row].psw
        location.adress = itemsInSection[indexPath.row].adress
        location.city = itemsInSection[indexPath.row].city
        
        //передаются данные о выбранной ячейке для детального представление
        let detailVC = DetailVC()
        viewService.showDetail(with: location)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


extension ChoiceCityVC: UITableViewDelegate {
    
    ///возвращает название выбранного города
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sections = viewService.fetchResultCityController.sections else { fatalError() }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as [AnyObject]? else {
            fatalError("нет данных")
        }
        let city = itemsInSection[indexPath.row].city
        viewService.chooseCity(with: city ?? "")
        navigationController?.popViewController(animated: true)
    }
}



