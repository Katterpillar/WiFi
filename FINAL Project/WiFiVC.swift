//
//  WiFIVC.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

class WiFiVC :  UIViewController {
    
    var wiFiList = UITableView(frame: .zero)
    var searchBar = UISearchBar(frame: .zero)
    var viewModel: WiFiViewModel {
        didSet {
            self.viewModel.dataDidChange = {
                self.wiFiList.reloadData()
            }
        }
    }
    var term = "Москва" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.button.setTitle(self.term, for: .normal)
            }
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(term, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 17.0)
        button.setImage(UIImage(named: "247210-selection-cursors-1"), for: .normal)
        button.addTarget(self, action: #selector(pushChooseCityVC), for: .touchDown)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(viewModel: WiFiViewModel = WiFiViewModel()) {
        self.viewModel = WiFiViewModel()
        
        defer {
            self.viewModel = viewModel
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubview()
        setupConstraints()
        
        navigationItem.title = "Wi-Fi Map"
        view.backgroundColor = UIColor(red:0.75, green:0.86, blue:0.87, alpha:1.0)
        wiFiList.dataSource = self
        wiFiList.delegate = self
        searchBar.delegate = self
        wiFiList.register(UITableViewCell.self, forCellReuseIdentifier: "cellFromCoreData")
        searchBar.showsCancelButton = true        
        chooseCity(with: term)
        
    }
    
    
    func addSubview(){
        view.addSubview(wiFiList)
        view.addSubview(searchBar)
        view.addSubview(button)
    }
    
    func loadList() {
        viewModel.loadList()
    }
    
    func chooseCity(with city: String){
        viewModel.chooseCity(with: term)
    }
    
    func setupConstraints(){
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -15).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        wiFiList.translatesAutoresizingMaskIntoConstraints = false
        wiFiList.topAnchor.constraint(equalTo:searchBar.bottomAnchor, constant: 30).isActive = true
        wiFiList.widthAnchor.constraint(equalTo: searchBar.widthAnchor).isActive = true
        wiFiList.centerXAnchor.constraint(equalTo: searchBar.centerXAnchor).isActive = true
        wiFiList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    @objc func pushChooseCityVC() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    
}

extension WiFiVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension WiFiVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let section =  viewModel.fetchResultController.sections else { return 1 }
        return section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewModel.fetchResultController.sections else { return 1 }
        return sections[section].numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellFromCoreData = tableView.dequeueReusableCell(withIdentifier: "cellFromCoreData", for: indexPath)
        
        guard let sections = viewModel.fetchResultController.sections else {return UITableViewCell() }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError("нет данных")
        }
        cellFromCoreData.textLabel?.text = itemsInSection[indexPath.row].adress
        return cellFromCoreData
    }
    
}


extension WiFiVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard let searchBarText = searchBar.text else { return }
        viewModel.searchActivate(with: searchBarText, and: term)
    }
}



