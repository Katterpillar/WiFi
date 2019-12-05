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
class DetailFavoritesVC : UIViewController {
    
    var adress = UITextView(frame: .zero)
    var id = UITextView(frame: .zero)
    var psw = UITextView(frame: .zero)
    var city = UITextView(frame: .zero)

    /// экземпляр view model
    var viewModel: FavoritesViewModels {
        didSet{
            // устанавливает значение соответствующих полей
            self.viewModel.setupDetails = { details in
                DispatchQueue.main.async {
                    self.id.text = details.id
                    self.adress.text = details.adress
                    self.psw.text = details.psw
                    self.city.text = details.city
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
        view.addSubview(city)

    }
    
    func setupConstrains() {
        city.translatesAutoresizingMaskIntoConstraints = false
        city.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  70).isActive = true
        city.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        city.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        city.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        adress.translatesAutoresizingMaskIntoConstraints = false
        adress.topAnchor.constraint(equalTo: city.bottomAnchor, constant:  50).isActive = true
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
        
        
        self.city.layer.cornerRadius = 10
        self.adress.layer.cornerRadius = 10
        self.id.layer.cornerRadius = 10
        self.psw.layer.cornerRadius = 10
        
        city.font = UIFont(name: "Helvetica", size: 18.0)
        adress.font = UIFont(name: "Helvetica", size: 18.0)
        id.font = UIFont(name: "Helvetica", size: 18.0)
        psw.font = UIFont(name: "Helvetica", size: 18.0)
        
        
        self.city.backgroundColor = .white
        self.adress.backgroundColor = .white
        self.id.backgroundColor = .white
        self.psw.backgroundColor = .white
        
        self.city.textAlignment = .center
        self.adress.textAlignment = .center
        self.id.textAlignment = .center
        self.psw.textAlignment = .center
        
        
        self.adress.textColor = .black
        self.id.textColor = .black
        self.psw.textColor = .black
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red:0.75, green:0.86, blue:0.87, alpha:1.0)
    }
    
}

