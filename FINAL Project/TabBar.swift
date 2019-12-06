//
//  TapBar.swift
//  Wi-Fi_Map
//
//  Created by Katherine on 26/11/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

/// Создает таб бар,переключающий основные фунции приложения
class TabBarViewController : UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let addLocationVC = UINavigationController(rootViewController: AddLocationVC())
         addLocationVC.tabBarItem = UITabBarItem.init(title: "добавить локацию", image: UIImage(named: "location"), tag: 1)

        
        
        let wiFiListVC = UINavigationController(rootViewController: WiFiVC())
         wiFiListVC.tabBarItem = UITabBarItem.init(title: "поиск", image: UIImage(named: "search"), tag: 2)
   
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesVC())
        favoritesVC.tabBarItem = UITabBarItem.init(title: "избранное", image: UIImage(named: "favorites"), tag: 3)

        
        tabBar.tintColor =  UIColor(red:0.69, green:0.79, blue:0.50, alpha:1.0)
        self.viewControllers = [addLocationVC, wiFiListVC, favoritesVC]
    }
    
}
