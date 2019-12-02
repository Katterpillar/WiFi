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
         addLocationVC.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "add-location"), tag: 1)

        
        
        let wiFiListVC = UINavigationController(rootViewController: UIViewController())
         wiFiListVC.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "search1"), tag: 2)
   
        
        let favoritesVC = UINavigationController(rootViewController: UIViewController())
        favoritesVC.tabBarItem = UITabBarItem.init(title: "", image: UIImage(named: "favorites"), tag: 3)

        
        
        self.viewControllers = [addLocationVC, wiFiListVC, favoritesVC]
    }
    
}