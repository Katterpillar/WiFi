//
//  ChooseCityVC.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewControllerDelegate {
    func updateWiFiList(with myData: String)
}

class ChoiceCityVC :  UIViewController {
    
    var viewModel: WiFiViewModel
    
    var detailDelegate: DetailViewControllerDelegate?
    var cityList = UITableView(frame: .zero)
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidAppear(animated)
        
         viewModel.loadList()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.96, alpha:1.0)
        
        
        addSubview()
        setupConstraints()
       
        
        
    }
    
    
    func addSubview(){
        view.addSubview(cityList)
        
        cityList.dataSource = self
        cityList.delegate = self
        cityList.register(UITableViewCell.self, forCellReuseIdentifier: "city")
        
    }
    
    func setupConstraints(){
        
        cityList.translatesAutoresizingMaskIntoConstraints = false
        cityList.topAnchor.constraint(equalTo:view.topAnchor, constant: 30).isActive = true
        cityList.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        cityList.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}

extension ChoiceCityVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewModel.fetchResultController.sections else { return 1 }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cityList.dequeueReusableCell(withIdentifier: "city") else {
            fatalError()
        }
        guard let sections = viewModel.fetchResultController.sections else { fatalError() }
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [WiFiLock] else {
            fatalError("нет данных")
        }
        cell.textLabel?.text = itemsInSection[indexPath.row].city
        return cell
    }
    
    
}

extension ChoiceCityVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.popViewController(animated: true)
    }
}

