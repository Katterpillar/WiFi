//
//  Detail.swift
//  FINAL Project
//
//  Created by Katherine on 04/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

/// вью, показывающее детальную информации по точке
class DetailFavoritesVC : UIViewController {
    
    var adress = UITextView(frame: .zero)
    var id = UITextView(frame: .zero)
    var psw = UITextView(frame: .zero)
    var city = UITextView(frame: .zero)
    
    var viewModel: FavoritesViewModels {
        didSet { DispatchQueue.main.async {
            self.viewModel.setupDetails = { [weak self] location in
                guard let self = self else { return }
                self.adress.text = location.adress
                self.city.text = location.city
                self.id.text = location.id
                self.psw.text = location.psw
            }
            
            }
        }
    }
    
    
    init(viewModel: FavoritesViewModels = FavoritesViewModels()) {
        self.viewModel = FavoritesViewModels()
        
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
        setupConstrains()
        
        navigationItem.title = "Описание"
    }
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(true)
        
    }
    
    func addSubviews() {
        
        view.addSubview(adress)
        view.addSubview(id)
        view.addSubview(psw)
        view.addSubview(city)
    }
    
    func setupConstrains() {
        adress.translatesAutoresizingMaskIntoConstraints = false
        adress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  70).isActive = true
        adress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        adress.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        city.translatesAutoresizingMaskIntoConstraints = false
        city.topAnchor.constraint(equalTo: adress.bottomAnchor, constant: 50).isActive = true
        city.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        city.widthAnchor.constraint(equalTo:  adress.widthAnchor).isActive = true
        city.heightAnchor.constraint(equalTo:adress.heightAnchor).isActive = true
        
        id.translatesAutoresizingMaskIntoConstraints = false
        id.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 50).isActive = true
        id.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        id.widthAnchor.constraint(equalTo:  adress.widthAnchor).isActive = true
        id.heightAnchor.constraint(equalTo: adress.heightAnchor).isActive = true
        
        
        psw.translatesAutoresizingMaskIntoConstraints = false
        psw.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 50).isActive = true
        psw.widthAnchor.constraint(equalTo: adress.widthAnchor, multiplier: 0.7).isActive = true
        psw.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        psw.heightAnchor.constraint(equalTo: adress.heightAnchor).isActive = true
        
        
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
    
    /// функция, устанавливающая значения для детального отображения элементов
    ///
    /// - Parameters:
    ///   - adress: адрес точки
    ///   - id: имя точки
    ///   - psw: пароль от вай-фая
    ///   - city: город
    func setupDetails(adress: String, id: String, psw: String, city: String) {
        
        DispatchQueue.main.async {
        
        }
        
        view.backgroundColor = UIColor(red:0.75, green:0.86, blue:0.87, alpha:1.0)
       
    }
    
    
    
}


