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
    
    var data = ["Дмитров","Железнодорожный","Москва","Орехово-Зуево","Павловский-Посад"]
    var detailDelegate: DetailViewControllerDelegate?
    var cityList = UITableView(frame: .zero)
    var wifiTableDelegate: DetailViewControllerDelegate?
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
    
    func addCity(city: String) {
        if data.contains(city.capitalizingFirstLetter()) {
            return
        }
        data.append(city.capitalizingFirstLetter())
    }
    
}

extension ChoiceCityVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cityList.dequeueReusableCell(withIdentifier: "city") else {
            fatalError()
        }
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
}

extension ChoiceCityVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wifiTableDelegate?.updateWiFiList(with: data[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
