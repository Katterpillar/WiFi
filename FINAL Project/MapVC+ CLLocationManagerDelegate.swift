//
//  MapVC+ Delegate.swift
//  FINAL Project
//
//  Created by Katherine on 09/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


extension MapVC: CLLocationManagerDelegate{
    ///возвращает пользоваательскую геолокацию
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let location = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01 )
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
}
