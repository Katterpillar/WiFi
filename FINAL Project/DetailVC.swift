//
//  DetailVC.swift
//  FINAL Project
//
//  Created by Katherine on 04/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

/// вью, показывающее детальную информацию о выбранной вай-фай точке
class DetailVC : UIViewController {
    
    var adress = UITextView(frame: .zero)
    var id = UITextView(frame: .zero)
    var psw = UITextView(frame: .zero)
    var city = String()
    var addToFavoritesList = UIButton(frame: .zero)
    /// экземпляр view model
    var viewModel: WiFiViewService {
        didSet{
            // устанавливает значение соответствующих полей
            self.viewModel.setupDetails = { details in
                DispatchQueue.main.async {
                    self.id.text = details.id
                    self.adress.text = details.adress
                    self.psw.text = details.psw
                    self.city = details.city
                }
            }
        }
    }
    
    
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addSubviews()
        setupView()
        setupConstrains()
        navigationItem.title = "Описание"
    }
    
    func addSubviews() {
        
        view.addSubview(adress)
        view.addSubview(id)
        view.addSubview(psw)
        view.addSubview(addToFavoritesList)
    }
    
    func setupConstrains() {
        adress.translatesAutoresizingMaskIntoConstraints = false
        adress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  70).isActive = true
        adress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        adress.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        id.translatesAutoresizingMaskIntoConstraints = false
        id.topAnchor.constraint(equalTo: adress.bottomAnchor, constant: 50).isActive = true
        id.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        id.widthAnchor.constraint(equalTo:  adress.widthAnchor).isActive = true
        id.heightAnchor.constraint(equalTo:adress.heightAnchor).isActive = true
        
        psw.translatesAutoresizingMaskIntoConstraints = false
        psw.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 50).isActive = true
        psw.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        psw.widthAnchor.constraint(equalTo:  adress.widthAnchor).isActive = true
        psw.heightAnchor.constraint(equalTo: adress.heightAnchor).isActive = true
        
        
        addToFavoritesList.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesList.topAnchor.constraint(equalTo: psw.bottomAnchor, constant: 50).isActive = true
        addToFavoritesList.widthAnchor.constraint(equalTo: adress.widthAnchor, multiplier: 0.7).isActive = true
        addToFavoritesList.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addToFavoritesList.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        
        self.adress.layer.cornerRadius = 10
        self.id.layer.cornerRadius = 10
        self.psw.layer.cornerRadius = 10
        
        adress.font = UIFont(name: "Helvetica", size: 16.0)
        id.font = UIFont(name: "Helvetica", size: 16.0)
        psw.font = UIFont(name: "Helvetica", size: 16.0)
        
        
        
        self.adress.backgroundColor = .white
        self.id.backgroundColor = .white
        self.psw.backgroundColor = .white
        
        self.adress.textAlignment = .center
        self.id.textAlignment = .center
        self.psw.textAlignment = .center
        
        
        self.adress.textColor = .black
        self.id.textColor = .black
        self.psw.textColor = .black
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red:0.75, green:0.86, blue:0.87, alpha:1.0)
        addToFavoritesList.setTitle("В избранное", for: .normal)
        addToFavoritesList.addTarget(self, action: #selector(addToFavoritesCoreData), for: .touchUpInside)
        
        addToFavoritesList.backgroundColor = UIColor(red:0.87, green:0.69, blue:0.40, alpha:1.0)
        addToFavoritesList.layer.cornerRadius = 5
    }
    
    /// добавляет точку в избранное
    @objc func addToFavoritesCoreData(){
        let location = WiFiEntity(adress: self.adress.text, city: self.city, id: self.id.text, psw: self.psw.text)
      viewModel.addToFavorites(location)
    }
    
    
}

