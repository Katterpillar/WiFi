//
//  File.swift
//  FINAL Project
//
//  Created by Katherine on 04/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

/// вью для избранного
class FavoritesVC : UIViewController {
    
    internal var wiFiList = UITableView(frame: .zero)
    internal var viewService: FavoritesViewService {
        didSet {
            self.viewService.dataDidChange = {
                DispatchQueue.main.async {
                    self.wiFiList.reloadData()
                }
            }
        }
        
    }
    
    init(viewModel: FavoritesViewService = FavoritesViewService.shared) {
        self.viewService = FavoritesViewService()
        defer {
            self.viewService = viewModel
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///загружает данные для представления их в таблице
    override func viewWillAppear(_ animated: Bool) {
        self.viewService.loadFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        setupConstraints()
        setupView()
        
        wiFiList.delegate = self
        wiFiList.dataSource = self
        wiFiList.register(UITableViewCell.self, forCellReuseIdentifier: "favoritesCell")
        view.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
    }
    
    /// добавляет объекты на вью
    private func addSubview(){
        view.addSubview(wiFiList)
    }
    
    /// настараивает Constraints
    private func setupConstraints(){
        wiFiList.translatesAutoresizingMaskIntoConstraints = false
        wiFiList.topAnchor.constraint(equalTo:view.topAnchor, constant: 30).isActive = true
        wiFiList.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        wiFiList.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wiFiList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    ///настраивает атрибуты представления: шрифт заголовка, название окна, цвет
    private func setupView() {
        navigationItem.title = "Избранное"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.backgroundColor =  UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
    }
}


