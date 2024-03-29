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
    internal var addAdressTextView = UITextView(frame: .zero)
    internal var addIdTextView = UITextView(frame: .zero)
    internal var addCityTextView = UITextView(frame: .zero)
    internal var addPswTextView = UITextView(frame: .zero)
    private var addButton = CustomButton(color: UIColor(red:0.69, green:0.79, blue:0.50, alpha:1.0), title: "Добавить")
    private var cityLbl = UILabel(frame: .zero)
    private var adressLbl = UILabel(frame: .zero)
    private var idLbl = UILabel(frame: .zero)
    private var pswLbl = UILabel(frame: .zero)
    
    /// экземпляр viewmodel
    internal var viewModel: AddLocationViewModel {
        didSet {
            ///показывает сообщение, если какое-либо поле не записано
            self.viewModel.showAlert = { alertText in
                let alert = UIAlertController(title: "Ошибка", message: alertText, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in }))
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
            ///оповещает о том, что в окошко что-то записали
            self.viewModel.formDataDidChange = {
                self.refreshFormData()
            }
            ///высвечивает алерт при неправильном заполнении окон
            self.viewModel.formDataWillChange = { textView in
                
                if self.addIdTextView == textView{
                    DispatchQueue.main.async {
                        self.addIdTextView.text = ""
                        self.addIdTextView.textColor = .black
                    }
                }
                if self.addCityTextView == textView{
                    DispatchQueue.main.async {
                        self.addCityTextView.text = ""
                        self.addCityTextView.textColor = .black
                    }
                }
                if self.addPswTextView == textView{
                    DispatchQueue.main.async {
                        self.addPswTextView.text = ""
                        self.addPswTextView.textColor = .black
                    }
                }
                if self.addAdressTextView == textView{
                    DispatchQueue.main.async {
                        self.addAdressTextView.text = ""
                        self.addAdressTextView.textColor = .black
                        
                    }
                }
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
        setupIdConstrains()
        setupAdressConstrains()
        setupCityConstrains()
        setupPswConstrains()
        setupButtonConstrains()
        setupDetails()
        setupTextDetail()
    }
    
    private func addSubviews(){
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
    
    ///
    private func setupIdConstrains() {
        idLbl.translatesAutoresizingMaskIntoConstraints = false
        idLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.01).isActive = true
        idLbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        idLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idLbl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04).isActive = true
        
        addIdTextView.translatesAutoresizingMaskIntoConstraints = false
        addIdTextView.topAnchor.constraint(equalTo: idLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        addIdTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        addIdTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addIdTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    ///
    private func setupPswConstrains() {
        pswLbl.translatesAutoresizingMaskIntoConstraints = false
        pswLbl.topAnchor.constraint(equalTo: addIdTextView.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        pswLbl.widthAnchor.constraint(equalTo: addIdTextView.widthAnchor).isActive = true
        pswLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pswLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        addPswTextView.translatesAutoresizingMaskIntoConstraints = false
        addPswTextView.topAnchor.constraint(equalTo: pswLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        addPswTextView.widthAnchor.constraint(equalTo: addIdTextView.widthAnchor).isActive = true
        addPswTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPswTextView.heightAnchor.constraint(equalTo: addIdTextView.heightAnchor).isActive = true
    }
    
    ///
    private func setupCityConstrains() {
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.topAnchor.constraint(equalTo: addPswTextView.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        cityLbl.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        cityLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        
        addCityTextView.translatesAutoresizingMaskIntoConstraints = false
        addCityTextView.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        addCityTextView.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        addCityTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addCityTextView.heightAnchor.constraint(equalTo: addPswTextView.heightAnchor).isActive = true
    }
    
    ///
    private func setupAdressConstrains() {
        adressLbl.translatesAutoresizingMaskIntoConstraints = false
        adressLbl.topAnchor.constraint(equalTo: addCityTextView.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        adressLbl.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        adressLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adressLbl.heightAnchor.constraint(equalTo: idLbl.heightAnchor).isActive = true
        addAdressTextView.translatesAutoresizingMaskIntoConstraints = false
        addAdressTextView.topAnchor.constraint(equalTo: adressLbl.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
        addAdressTextView.widthAnchor.constraint(equalTo: addPswTextView.widthAnchor).isActive = true
        addAdressTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addAdressTextView.heightAnchor.constraint(equalTo: addPswTextView.heightAnchor).isActive = true
    }
    
    ///
    private func setupButtonConstrains() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.topAnchor.constraint(equalTo: addAdressTextView.bottomAnchor, constant: view.frame.height * 0.04).isActive = true
        addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    /// устанавливает атрибуты отображения для текстовых полей: шрифт, название поля
    private func setupTextDetail(){
        addPswTextView.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        addIdTextView.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        addAdressTextView.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        addCityTextView.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        
        addPswTextView.autocapitalizationType = .none
        addIdTextView.autocapitalizationType = .none
        addAdressTextView.autocapitalizationType = .none
        
        addPswTextView.autocorrectionType = .no
        addIdTextView.autocorrectionType = .no
        addAdressTextView.autocorrectionType = .no
        addCityTextView.autocorrectionType = .no
        
        
        idLbl.backgroundColor = .clear
        idLbl.text = "Введите id роутера"
        idLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        idLbl.textColor = .black
        idLbl.textAlignment = .natural
        
        pswLbl.backgroundColor = .clear
        pswLbl.textColor = .black
        pswLbl.text = "Введите пароль от роутера"
        pswLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        pswLbl.textAlignment = .natural
        
        cityLbl.backgroundColor = .clear
        cityLbl.text = "Введите город"
        cityLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        cityLbl.textColor = .black
        cityLbl.textAlignment = .natural
        
        adressLbl.backgroundColor = .clear
        adressLbl.textColor = .black
        adressLbl.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        adressLbl.text = "Введите адрес"
        adressLbl.textAlignment = .natural
    }
    
    ///устанавливает детали отображения: закругление, заголовок, а так же добавляет Target  для кнопки
    private func setupDetails() {
        addButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        
        addIdTextView.delegate = self
        addAdressTextView.delegate = self
        addPswTextView.delegate = self
        addCityTextView.delegate = self
        
        addPswTextView.layer.cornerRadius = 10
        addIdTextView.layer.cornerRadius = 10
        addAdressTextView.layer.cornerRadius = 10
        addCityTextView.layer.cornerRadius = 10
        
        addPswTextView.textColor = .lightGray
        addAdressTextView.textColor = .lightGray
        addCityTextView.textColor = .lightGray
        addIdTextView.textColor = .lightGray
        
        DispatchQueue.main.async {
            self.addPswTextView.text = "пароль"
            self.addIdTextView.text = "id"
            self.addAdressTextView.text = "yлица, дом, корпус"
            self.addCityTextView.text = "город"
        }
        
        view.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        navigationItem.title = "Добавьте свою точку"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    ///добавляет пользовательскую локацию в список
    @objc func addLocation(){
        viewModel.addLocation()
    }
    
    ///оюбновляет данные в полях ввода текста по мере его введения пользователем
    private func refreshFormData() {
        DispatchQueue.main.async {
            self.addAdressTextView.text = self.viewModel.locationFormData.adress
            self.addCityTextView.text = self.viewModel.locationFormData.city
            self.addIdTextView.text = self.viewModel.locationFormData.adress
            self.addPswTextView.text = self.viewModel.locationFormData.adress
        }
    }
    
    ///инициализирует нажатие на любое свободное место на вью для отмены ввода
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
}

