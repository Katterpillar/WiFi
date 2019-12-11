//
//  ChooseCityVC.swift
//  FINAL Project
//
//  Created by Katherine on 03/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit


class ChoiceCityVC :  UIViewController {
    
    internal var detailDelegate: DetailViewControllerDelegate?
    internal var cityList = UITableView(frame: .zero)
    
    internal var viewService: WiFiViewServiceProtocol
    
    init(viewModel: WiFiViewServiceProtocol = WiFiViewService.shared) {
        self.viewService = WiFiViewService()
        
        defer {
            self.viewService = viewModel
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubview()
        setupConstraints()
        viewService.loadCityList()
    }
    
    ///  добавляет все объекты на view
    private func addSubview(){
        view.addSubview(cityList)
 
    }
    
    ///устанавливает некоторые атрибуты для корректного отображения  
    private func setupComponents(){
        view.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = "Выберите город"
        cityList.dataSource = self
        cityList.delegate = self
        cityList.register(UITableViewCell.self, forCellReuseIdentifier: "city")
    }
    
    /// устанавливает Constraints для объектов, добавленных на view
    private func setupConstraints(){
        cityList.translatesAutoresizingMaskIntoConstraints = false
        cityList.topAnchor.constraint(equalTo:view.topAnchor, constant: 30).isActive = true
        cityList.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        cityList.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}




