//
//  WiFIVC.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

/// основная вью, на которой распологается список доступных вай-фай точек
class WiFiVC :  UIViewController {
    
    var wiFiList = UITableView(frame: .zero)
    var searchBar = UISearchBar(frame: .zero)
    var reloadDataWorkItem : DispatchWorkItem?
    //view model экземпляр
    var viewModel: WiFiViewService {
        didSet {
            // оповещате о том, что список был изменен и необходимо обновить таблицу
            self.viewModel.dataDidLoad = {
                self.reloadDataWorkItem = DispatchWorkItem { [weak self] in
                    guard let self = self else{
                        return
                    }
                    print(self.reloadDataWorkItem!.isCancelled)
                    if self.reloadDataWorkItem!.isCancelled { return  }
                    self.wiFiList.reloadData()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: self.reloadDataWorkItem!)
                
            }
            self.viewModel.dataDidChange = {
                DispatchQueue.main.async {
                    self.viewModel.loadList()
                    self.wiFiList.reloadData()
                }
            }
            self.viewModel.cityChange = { city in
                DispatchQueue.main.async {
                    self.chooseCityBtn.setTitle(city, for: .normal)
                }
            }
        }
        
    }
    
    
    /// название города
    var term = "Москва" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.chooseCityBtn.titleLabel?.text = self.term
            }
        }
    }
    
    /// по нажатию на эту кнопку открывается список городов
    lazy var chooseCityBtn: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.text = term
        button.setTitle(term, for: .normal)
        button.titleLabel?.font = UIFont(name: "STHeitiSC-Medium", size: 25.0)
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var choose: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor(red:0.69, green:0.79, blue:0.50, alpha:0.5)
        button.layer.cornerRadius = view.frame.width * 0.09 * 0.5
        button.addTarget(self, action: #selector(pushChooseCityVC), for: .touchDown)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.setImage(UIImage(named: "smashicons"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(viewModel: WiFiViewService = WiFiViewService.shared) {
        self.viewModel = WiFiViewService()
        defer {
            self.viewModel = viewModel
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadList()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubview()
        setupConstraints()
        
        navigationItem.title = "Wi-Fi Map"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        wiFiList.dataSource = self
        wiFiList.delegate = self
        searchBar.delegate = self
        wiFiList.register(UITableViewCell.self, forCellReuseIdentifier: "cellFromCoreData")
        searchBar.backgroundColor = .white
        searchBar.barTintColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        searchBar.tintColor = UIColor(red:0.79, green:0.79, blue:0.81, alpha:1.0)
        chooseCity(with: term)
        
    }
    
    
    func addSubview(){
        view.addSubview(wiFiList)
        view.addSubview(searchBar)
        view.addSubview(chooseCityBtn)
        view.addSubview(choose)
    }
    
    
    func chooseCity(with city: String){
        viewModel.chooseCity(with: term)
    }
    
    func setupConstraints(){
        
        chooseCityBtn.translatesAutoresizingMaskIntoConstraints = false
        chooseCityBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.015).isActive = true
        chooseCityBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        chooseCityBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseCityBtn.heightAnchor.constraint(equalToConstant: view.frame.height * 0.07).isActive = true
        
        choose.translatesAutoresizingMaskIntoConstraints = false
        choose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.028).isActive = true
        choose.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        choose.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  -view.frame.width * 0.1).isActive = true
        choose.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.09).isActive = true
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.1).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        
        wiFiList.translatesAutoresizingMaskIntoConstraints = false
        wiFiList.topAnchor.constraint(equalTo:searchBar.bottomAnchor).isActive = true
        wiFiList.widthAnchor.constraint(equalTo: searchBar.widthAnchor).isActive = true
        wiFiList.centerXAnchor.constraint(equalTo: searchBar.centerXAnchor).isActive = true
        wiFiList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    /// показывется список городов
    @objc func pushChooseCityVC() {
        navigationController?.pushViewController(ChoiceCityVC(), animated: true)
    }
    
    
}

extension WiFiVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let sections = viewModel.fetchResultController.sections else {
            fatalError()
        }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError()
        }
        
        var location = WiFiEntity()
        location.id = itemsInSection[indexPath.row].id
        location.psw = itemsInSection[indexPath.row].psw
        location.adress = itemsInSection[indexPath.row].adress
        location.city = itemsInSection[indexPath.row].city
        
        //передаются данные о выбранной ячейке для детального представление
        let detailVC = DetailVC()
        viewModel.showDetail(with: location)
        navigationController?.pushViewController(detailVC, animated: true)
        
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
        
        guard let sections = viewModel.fetchResultController.sections else { fatalError() }
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


extension WiFiVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard let searchBarText = searchBar.text else { return }
        viewModel.searchActivate(with: searchBarText, and: term)
    }
}

extension UIButton {
    func addRightImage(image: UIImage, offset: CGFloat) {
        self.setImage(image, for: .normal)
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
    }
}


