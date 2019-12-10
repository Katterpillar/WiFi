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
    //view model экземпляр
    var viewModel: WiFiViewService {
        didSet {
            // оповещате о том, что список был изменен и необходимо обновить таблицу
            self.viewModel.dataDidLoad = { [weak self] in
                    guard let self = self else{
                        return
                    }
                    self.wiFiList.reloadData()
                }
            
            self.viewModel.dataDidChange = {
                DispatchQueue.main.async {
                    self.viewModel.loadList()
                    self.wiFiList.reloadData()
                }
            }
            self.viewModel.cityChange = { city in
                DispatchQueue.main.async {
                    self.cityLbl.text = city
                }
            }
        }
        
    }
    
    
    /// название города
    var term = "Москва" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.cityLbl.text = self.term
            }
        }
    }
    
    lazy var cityLbl: UILabel = {
        let button = UILabel(frame: .zero)
        button.text = term
        button.numberOfLines = 1
        button.minimumScaleFactor = 0.5
        button.textAlignment = .center
        button.adjustsFontSizeToFitWidth = true
        button.font = UIFont(name: "STHeitiSC-Medium", size: 25.0)
        return button
    }()
    
    /// по нажатию на эту кнопку открывается список городов
    lazy var choose: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor(red:0.69, green:0.79, blue:0.50, alpha:0.5)
        button.layer.cornerRadius = view.frame.width * 0.1 * 0.5
        button.addTarget(self, action: #selector(pushChooseCityVC), for: .touchDown)
        button.layer.borderWidth = 0.8
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
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        wiFiList.dataSource = self
        wiFiList.delegate = self
        searchBar.delegate = self
        wiFiList.register(UITableViewCell.self, forCellReuseIdentifier: "cellFromCoreData")
        searchBar.backgroundColor = .white
        searchBar.barTintColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        searchBar.tintColor = UIColor(red:0.79, green:0.79, blue:0.81, alpha:1.0)
        
    }
    
    func addSubview(){
        view.addSubview(wiFiList)
        view.addSubview(searchBar)
        view.addSubview(cityLbl)
        view.addSubview(choose)
    }
    
    func setupConstraints(){
        
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.015).isActive = true
        cityLbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        cityLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLbl.heightAnchor.constraint(equalToConstant: view.frame.height * 0.07).isActive = true
        
        choose.translatesAutoresizingMaskIntoConstraints = false
        choose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.025).isActive = true
        choose.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        choose.rightAnchor.constraint(equalTo: view.rightAnchor, constant:  -view.frame.width * 0.1).isActive = true
        choose.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}

