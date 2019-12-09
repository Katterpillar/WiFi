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
    
    var wiFiList = UITableView(frame: .zero)
    var viewModel: FavoritesViewModels {
        didSet {
            self.viewModel.dataDidChange = {
                DispatchQueue.main.async {
                    self.wiFiList.reloadData()
                }
            }
        }
        
    }
    
    init(viewModel: FavoritesViewModels = FavoritesViewModels.shared) {
        self.viewModel = FavoritesViewModels()
        defer {
            self.viewModel = viewModel
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.loadFromCoreData()
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
    func addSubview(){
        view.addSubview(wiFiList)
        
    }
    
    /// настараивает Constraints
    func setupConstraints(){
        
        wiFiList.translatesAutoresizingMaskIntoConstraints = false
        wiFiList.topAnchor.constraint(equalTo:view.topAnchor, constant: 30).isActive = true
        wiFiList.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        wiFiList.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wiFiList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupView() {
        
        navigationItem.title = "Избранное"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.backgroundColor =  UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        
    }
}

extension FavoritesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let sections = viewModel.fetchResultController.sections else {
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
        viewModel.showDetail(with: location)
        navigationController?.pushViewController( detailVC, animated: true)
    }
    
}

extension FavoritesVC: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel.fetchResultController.sections else {
            return 1
        }
        return sections.count
    }  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewModel.fetchResultController.sections else {
            return 1
        }
        return sections[section].numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ( viewModel.fetchResultController.sections?.count != nil ) {
            
            let cellFromCoreData = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath)
            
            guard let sections = viewModel.fetchResultController.sections else {
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Удалить") {
            _, indexPath in
            
            guard let sections = self.viewModel.fetchResultController.sections else {
                fatalError()
            }
            let section = sections[indexPath.section]
            guard let itemsInSection = section.objects as? [Favorites] else {
                fatalError()
            }
            let location = itemsInSection[indexPath.row].adress
            DispatchQueue.main.async {
                self.viewModel.deleteItem(with: location)
                self.viewModel.loadFromCoreData()
                self.wiFiList.deleteRows(at: [indexPath], with: .automatic)
                self.wiFiList.reloadData()
            }
        }
        return [deleteAction]
    }    
}





