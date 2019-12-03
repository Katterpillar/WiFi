//
//  WiFIVC.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

class WiFiTable :  UIViewController {
    
    var wiFiList = UITableView(frame: .zero)
    var welcomeText = UITextView(frame: .zero)
    var searchBar = UISearchBar(frame: .zero)

    
    var term = "Москва" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.button.setTitle(self.term, for: .normal)
            }
        }
    }
    
    lazy var button  :UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(term, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 17.0)
        button.setImage(UIImage(named: "247210-selection-cursors-1"), for: .normal)
        button.addTarget(self, action: #selector(pushChooseCityVC), for: .touchDown)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubview()
        setupConstraints()
        
        
        navigationItem.title = "Wi-Fi Map"
        view.backgroundColor = UIColor(red:0.75, green:0.86, blue:0.87, alpha:1.0)
        //        initList.saveListToCoreData()
        
        
        wiFiList.dataSource = self
        wiFiList.delegate = self
        searchBar.delegate = self
        wiFiList.register(UITableViewCell.self, forCellReuseIdentifier: "cellFromCoreData")
        fetchResultController.delegate = self
        
        searchBar.showsCancelButton = true
        
        chooseCity()
        
        loadFromCoreData()
        wiFiList.reloadData()
        
    }
    
    
    func addSubview(){
        view.addSubview(wiFiList)
        view.addSubview(searchBar)
        view.addSubview(button)
    }
    
    func loadFromCoreData() {
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        self.wiFiList.reloadData()
    }
    
    func chooseCity(){
        fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", term)
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
        let vc = ChoiceCityVC()
        vc.wifiTableDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension WiFiTable: DetailViewControllerDelegate {
    func updateWiFiList(with myData: String) {
        DispatchQueue.main.async {
            self.term = myData
            self.chooseCity()
            self.loadFromCoreData()
            
        }
    }
}

extension WiFiTable: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let sections = fetchResultController.sections else {
            fatalError()
        }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError()
        }
        let adress = itemsInSection[indexPath.row].adress
        let id = itemsInSection[indexPath.row].id
        let psw = itemsInSection[indexPath.row].psw
        
        details.setupDetails(adress: adress, id: id, psw: psw)
        
        navigationController?.pushViewController(details, animated: true)
        
        
    }
    
}

extension WiFiTable: UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchResultController.sections else {
            fatalError()
        }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchResultController.sections else {
            fatalError()
        }
        return sections[section].numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellFromCoreData = tableView.dequeueReusableCell(withIdentifier: "cellFromCoreData", for: indexPath)
        
        
        
        guard let sections = fetchResultController.sections else {
            fatalError()
        }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError()
        }
        cellFromCoreData.textLabel?.text = itemsInSection[indexPath.row].adress
        return cellFromCoreData
        
        
    }
    
    
    
}


extension WiFiTable: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        let searchBarText = searchBar.text
        if searchBarText == "" {
            
            fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", self.title ?? "")
            loadFromCoreData()
        } else {
            let predicate1 = NSPredicate(format: "city CONTAINS[c] %@", term)
            
            let predicate2 = NSPredicate(format: "adress CONTAINS[c] %@", searchBarText ?? "")
            let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: [predicate1,predicate2])
            
            fetchResultController.fetchRequest.predicate = predicateCompound
            
            loadFromCoreData()
        }
        
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        fetchResultController.fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", term)
        loadFromCoreData()
        wiFiList.reloadData() }
    
    
}


