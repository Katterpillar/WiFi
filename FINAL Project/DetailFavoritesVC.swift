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
    
    private var adress =  UILabel(frame: .zero)
    private var id =  UILabel(frame: .zero)
    private var psw = UILabel(frame: .zero)
    private var city = UILabel(frame: .zero)
    private var idLbl = UILabel(frame: .zero)
    private var pswLbl = UILabel(frame: .zero)
    private var adressLbl = UILabel(frame: .zero)
    private var cityLbl = UILabel(frame: .zero)
    private var addToFavoritesList = UIButton(frame: .zero)
    
    /// экземпляр view model
    var viewModel: FavoritesViewService {
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
    
    
    init(viewModel: FavoritesViewService = FavoritesViewService.shared) {
        self.viewModel = FavoritesViewService()
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
        setupIdConstrains()
        setupAdressConstrains()
        setupCityConstrains()
        setupPswConstrains()
        setupFont()
    }
    
    /// добавляет элементы на view
    private func addSubviews() {
        view.addSubview(adress)
        view.addSubview(id)
        view.addSubview(psw)
        view.addSubview(city)
        view.addSubview(idLbl)
        view.addSubview(pswLbl)
        view.addSubview(cityLbl)
        view.addSubview(adressLbl)
        view.addSubview(addToFavoritesList)
    }
    
    /// настраивает Constrains для полей причастных к id
    private func setupIdConstrains() {
        idLbl.translatesAutoresizingMaskIntoConstraints = false
        idLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.01).isActive = true
        idLbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        idLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idLbl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04).isActive = true
        
        id.translatesAutoresizingMaskIntoConstraints = false
        id.topAnchor.constraint(equalTo: idLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        id.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        id.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        id.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    /// настраивает Constrains для полей причастных к адресу
    private func  setupAdressConstrains(){
        adressLbl.translatesAutoresizingMaskIntoConstraints = false
        adressLbl.topAnchor.constraint(equalTo: city.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        adressLbl.widthAnchor.constraint(equalTo: psw.widthAnchor).isActive = true
        adressLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adressLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        adress.translatesAutoresizingMaskIntoConstraints = false
        adress.topAnchor.constraint(equalTo: adressLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        adress.widthAnchor.constraint(equalTo: psw.widthAnchor).isActive = true
        adress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adress.heightAnchor.constraint(equalTo: psw.heightAnchor).isActive = true
        adress.sizeToFit()
        adress.numberOfLines = 4
    }
    
    /// настраивает Constrains для полей причастных к паролю
    private func setupPswConstrains(){
        
        pswLbl.translatesAutoresizingMaskIntoConstraints = false
        pswLbl.topAnchor.constraint(equalTo: id.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        pswLbl.widthAnchor.constraint(equalTo: id.widthAnchor).isActive = true
        pswLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pswLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        psw.translatesAutoresizingMaskIntoConstraints = false
        psw.topAnchor.constraint(equalTo: pswLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        psw.widthAnchor.constraint(equalTo: id.widthAnchor).isActive = true
        psw.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        psw.heightAnchor.constraint(equalTo: id.heightAnchor).isActive = true
        
    }
    
    /// настраивает Constrains для полей причастных к городу
    private func setupCityConstrains(){
        
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.topAnchor.constraint(equalTo: psw.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        cityLbl.widthAnchor.constraint(equalTo: psw.widthAnchor).isActive = true
        cityLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        city.translatesAutoresizingMaskIntoConstraints = false
        city.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        city.widthAnchor.constraint(equalTo: psw.widthAnchor).isActive = true
        city.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        city.heightAnchor.constraint(equalTo: psw.heightAnchor).isActive = true
        city.sizeToFit()
        city.numberOfLines = 4
        
    }
    
    ///настраивает детали представления элементов: скругление, шрифт, названия
    private func setupView() {
        navigationItem.title = "Описание"
        view.backgroundColor =  UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        
        self.city.layer.masksToBounds = true
        self.city.layer.cornerRadius = 10
        self.adress.layer.masksToBounds = true
        self.adress.layer.cornerRadius = 10
        self.id.layer.masksToBounds = true
        self.id.layer.cornerRadius = 10
        self.psw.layer.masksToBounds = true
        self.psw.layer.cornerRadius = 10
        
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
        
        idLbl.backgroundColor = .clear
        idLbl.text = "Id роутера"
        idLbl.textColor = .black
        idLbl.textAlignment = .natural
        
        pswLbl.backgroundColor = .clear
        pswLbl.textColor = .black
        pswLbl.text = "Пароль: "
        pswLbl.textAlignment = .natural
        
        cityLbl.backgroundColor = .clear
        cityLbl.text = "Город"
        cityLbl.textColor = .black
        cityLbl.textAlignment = .natural
        
        adressLbl.backgroundColor = .clear
        adressLbl.textColor = .black
        adressLbl.text = "Адрес"
        adressLbl.textAlignment = .natural
    }
    
    ///настраивает шрифты
    private func setupFont(){
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        city.font = UIFont(name: "Helvetica", size: 16.0)
        adress.font = UIFont(name: "Helvetica", size: 16.0)
        id.font = UIFont(name: "Helvetica", size: 16.0)
        psw.font = UIFont(name: "Helvetica", size: 16.0)
        
        idLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        pswLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        cityLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        adressLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
    }
    
}

