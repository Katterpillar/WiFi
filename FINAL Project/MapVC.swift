//
//  Map.swift
//  FINAL Project
//
//  Created by Katherine on 09/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

///класс для отображения карты
class MapVC: UIViewController {
    
    internal var mapView = MKMapView(frame: .zero)
    private var mapService: MapService
    internal var mapLocation: MKPlacemark
    private var locationManager = CLLocationManager()
    
    init(mapService: MapService  = MapService()) {
        self.mapService = mapService
        self.mapLocation = MKPlacemark()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        
        view.addSubview(self.mapView)
        setupConstraint()
        setupView()
        addLocation()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///настраивает детали отображения окна
    private func setupView() {
        navigationItem.title = "Карта"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "STHeitiSC-Light", size: 25) ?? UIFont.systemFont(ofSize: 25.0)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.backgroundColor =  UIColor(red:0.98, green:0.86, blue:0.82, alpha:1.0)
        self.mapView.showsUserLocation = true
        self.mapView.showsScale = true
        self.mapView.isZoomEnabled = true
    }
    
    ///настраивает Constraint отображения карты
    private func setupConstraint(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    ///добавляет точки на карту
    private func addLocation(){
        for location in self.mapService.addAllLocation(){
            mapView.addAnnotation(location)
            
        }
    }
    
}
