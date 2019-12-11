//
//  Favorites + Delegate.swift
//  FINAL Project
//
//  Created by Katherine on 10/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

extension FavoritesVC: UITableViewDelegate{
    
    ///передает значения выбранной ячейки для детального отображения
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let sections = viewService.fetchResultController.sections else {
            fatalError()
        }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [Favorites] else {
            fatalError()
        }
        
        var location = WiFiEntity()
        location.id = itemsInSection[indexPath.row].id
        location.psw = itemsInSection[indexPath.row].psw
        location.adress = itemsInSection[indexPath.row].adress
        location.city = itemsInSection[indexPath.row].city
        
        let detailVC = DetailFavoritesVC()
        viewService.showDetail(with: location)
        navigationController?.pushViewController( detailVC, animated: true)
    }
    
    ///удаляет выбранную ячейку по свайпу вправо
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            
            guard let sections = self.viewService.fetchResultController.sections else {
                fatalError()
            }
            let section = sections[indexPath.section]
            guard let itemsInSection = section.objects as? [Favorites] else {
                fatalError()
            }
            let location = itemsInSection[indexPath.row].adress
            DispatchQueue.main.async {
                self.viewService.initDeleteItem(with: location)
                self.viewService.loadFromCoreData()
                self.wiFiList.deleteRows(at: [indexPath], with: .automatic)
                self.wiFiList.reloadData()
            }
        }
        return [deleteAction]
    }
    
}

