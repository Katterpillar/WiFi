//
//  AddLocationVC.swift
//  FINAL Project
//
//  Created by Katherine on 02/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit

/// вью для добавления пользовательской точки
class AddLocationVC: UIViewController {
    var addAdressTextView = UITextView(frame: .zero)
    var addIdTextView = UITextView(frame: .zero)
    var addCityTextView = UITextView(frame: .zero)
    var addPswTextView = UITextView(frame: .zero)
    var addButton = UIButton(frame: .zero)
    var cityLbl = UILabel(frame: .zero)
    var adressLbl = UILabel(frame: .zero)
    var idLbl = UILabel(frame: .zero)
    var pswLbl = UILabel(frame: .zero)
    
    /// жкземпляр viewmodel
    var viewModel: AddLocationViewModel {
        didSet {
            //показывает сообщение, если какое-либо поле не записано
            self.viewModel.showAlert = { alertText in
                let alert = UIAlertController(title: "Ошибка", message: alertText, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
            //оповещает о том, что в окошко что-то записали
            self.viewModel.formDataDidChange = {
                self.refreshFormData()
            }
        }
    }    
    
    init(viewModel: AddLocationViewModel = AddLocationViewModel()) {
        self.viewModel = AddLocationViewModel()
        
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
        setupConstraints()
        setupDetails()
        
        addButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        
        addIdTextView.delegate = self
        addAdressTextView.delegate = self
        addPswTextView.delegate = self
    }
    
    func addSubviews(){
        view.addSubview(addIdTextView)
        view.addSubview(addAdressTextView)
        view.addSubview(addCityTextView)
        view.addSubview(addPswTextView)
        view.addSubview(addButton)
        view.addSubview(idLbl)
        view.addSubview(pswLbl)
        view.addSubview(cityLbl)
        view.addSubview(adressLbl)
    }
    
    func setupConstraints() {
        
        idLbl.translatesAutoresizingMaskIntoConstraints = false
        idLbl.bottomAnchor.constraint(equalTo: addIdTextView.topAnchor).isActive = true
        idLbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        idLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idLbl.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        
        addIdTextView.translatesAutoresizingMaskIntoConstraints = false
        addIdTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        addIdTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        addIdTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addIdTextView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        
        
        pswLbl.translatesAutoresizingMaskIntoConstraints = false
        pswLbl.topAnchor.constraint(equalTo: addIdTextView.bottomAnchor, constant: 10).isActive = true
        pswLbl.widthAnchor.constraint(equalTo: addIdTextView.widthAnchor).isActive = true
        pswLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pswLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        addPswTextView.translatesAutoresizingMaskIntoConstraints = false
        addPswTextView.topAnchor.constraint(equalTo: pswLbl.bottomAnchor, constant: 10).isActive = true
        addPswTextView.widthAnchor.constraint(equalTo: addIdTextView.widthAnchor).isActive = true
        addPswTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPswTextView.heightAnchor.constraint(equalTo: addIdTextView.heightAnchor).isActive = true
        

        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.topAnchor.constraint(equalTo: addPswTextView.bottomAnchor, constant: 10).isActive = true
        cityLbl.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        cityLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        addCityTextView.translatesAutoresizingMaskIntoConstraints = false
        addCityTextView.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: 10).isActive = true
        addCityTextView.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        addCityTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addCityTextView.heightAnchor.constraint(equalTo: addPswTextView.heightAnchor).isActive = true
        
        
        adressLbl.translatesAutoresizingMaskIntoConstraints = false
        adressLbl.topAnchor.constraint(equalTo: addCityTextView.bottomAnchor, constant: 10).isActive = true
        adressLbl.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        adressLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adressLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        
        addAdressTextView.translatesAutoresizingMaskIntoConstraints = false
        addAdressTextView.topAnchor.constraint(equalTo: adressLbl.bottomAnchor, constant: 10).isActive = true
        addAdressTextView.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        addAdressTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addAdressTextView.heightAnchor.constraint(equalTo: addPswTextView.heightAnchor).isActive = true
        
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: addAdressTextView.bottomAnchor, constant: 50).isActive = true
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
    }
    
    func setupDetails() {
        
        addButton.setTitle("ADD", for: .normal)
        
        addButton.backgroundColor = UIColor(red:0.87, green:0.69, blue:0.40, alpha:1.0)
        addButton.layer.cornerRadius = 5
        
        addPswTextView.layer.cornerRadius = 10
        addIdTextView.layer.cornerRadius = 10
        addAdressTextView.layer.cornerRadius = 10
        addCityTextView.layer.cornerRadius = 10
        
        idLbl.backgroundColor = .clear
        idLbl.text = "Введите id роутера"
        idLbl.textColor = .black
        idLbl.textAlignment = .natural
        
        pswLbl.backgroundColor = .clear
        pswLbl.textColor = .black
        pswLbl.text = "Введите пароль от роутера"
        pswLbl.textAlignment = .natural
        
        cityLbl.backgroundColor = .clear
        cityLbl.text = "Введите город"
        cityLbl.textColor = .black
        cityLbl.textAlignment = .natural
        
        adressLbl.backgroundColor = .clear
        adressLbl.textColor = .black
        adressLbl.text = "Введите адрес"
        adressLbl.textAlignment = .natural
        
        view.backgroundColor = UIColor(red:0.75, green:0.86, blue:0.87, alpha:1.0)
        navigationItem.title = "Добавьте свою точку"
    }
    
    @objc func addLocation(){
        viewModel.addLocation()
    }
    
    func refreshFormData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addAdressTextView.text = self.viewModel.locationFormData.adress
            self.addCityTextView.text = self.viewModel.locationFormData.city
            self.addIdTextView.text = self.viewModel.locationFormData.adress
            self.addPswTextView.text = self.viewModel.locationFormData.adress
        }
    }
    
}

extension AddLocationVC : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
      
       viewModel.refreshLocation(addAdressText: addAdressTextView.text, addCityText:  addCityTextView.text, addIdText: addIdTextView.text, addPswText: addPswTextView.text)
        
    }
    
}
