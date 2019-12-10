//
//  ViewController+dataSource.swift
//  FINAL Project
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

extension WiFiVC: UITableViewDataSource {
    ///определяет количество секций на главном окне
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let section =  viewService.fetchResultController.sections else { return 1 }
        return section.count
    }
    
    ///определяет количество ячеек на главном окне
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewService.fetchResultController.sections else { return 1 }
        return sections[section].numberOfObjects
    }
    
    ///устанавливает данные ячейки в главном окне, а так же кастомизирует ее
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellFromCoreData = tableView.dequeueReusableCell(withIdentifier: "cellFromCoreData", for: indexPath)
        
        guard let sections = viewService.fetchResultController.sections else { fatalError() }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError("нет данных")
        }
        cellFromCoreData.textLabel?.font = UIFont(name: "HelveticaNeue", size: 16.0)
        cellFromCoreData.accessoryType = .disclosureIndicator
        cellFromCoreData.textLabel?.text = itemsInSection[indexPath.row].adress
        return cellFromCoreData
    }
    
}

extension ChoiceCityVC: UITableViewDataSource {
    
    ///определяет количество ячеек в окне выбора города
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewService.fetchResultCityController.sections else { return 1 }
        return sections[section].numberOfObjects
    }
    
    ///устанавливает данные ячейки, а так же кастомизирует ее для окна выбора города
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cityList.dequeueReusableCell(withIdentifier: "city") else {
            fatalError()
        }
        guard let sections = viewService.fetchResultCityController.sections else { fatalError() }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as [AnyObject]? else {
            fatalError("нет данных")
        }
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 16.0)
        cell.textLabel?.text = itemsInSection[indexPath.row].city
        return cell
    }
}

