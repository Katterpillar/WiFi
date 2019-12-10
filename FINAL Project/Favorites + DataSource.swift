//
//  Favorites + DataSource.swift
//  FINAL Project
//
//  Created by Katherine on 10/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

extension FavoritesVC: UITableViewDataSource {
    ///устанавливает количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewService.fetchResultController.sections else {
            return 1
        }
        return sections.count
    }
    
    ///устанавливает количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewService.fetchResultController.sections else {
            return 1
        }
        return sections[section].numberOfObjects
    }
    
    ///устанавливает данные ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ( viewService.fetchResultController.sections?.count != nil ) {
            
            let cellFromCoreData = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
            
            guard let sections = viewService.fetchResultController.sections else {
                fatalError()
            }
            let section = sections[indexPath.section]
            guard let itemsInSection = section.objects as? [Favorites] else {
                fatalError()
            }
            cellFromCoreData.textLabel?.font = UIFont(name: "HelveticaNeue", size: 16.0)
            cellFromCoreData.textLabel?.text = itemsInSection[indexPath.row].adress
            return cellFromCoreData
            
        } else { return UITableViewCell()  }
    }
    
}





