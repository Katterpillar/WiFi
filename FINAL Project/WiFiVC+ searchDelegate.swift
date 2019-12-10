//
//  WiFiVC+ searchDelegate.swift
//  FINAL Project
//
//  Created by Katherine on 08/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

extension WiFiVC: UISearchBarDelegate {
    ///сообщает о введенных пользователем символах
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard let searchBarText = searchBar.text else { return }
        viewService.searchActivate(with: searchBarText, and: term)
    }
}

