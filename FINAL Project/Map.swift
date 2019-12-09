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
import CoreData
import Contacts

class MapVC: UIViewController {
    
    var window: UIWindow?
    var mapView: MKMapView?
    var coreDataStack: CoreDataStack
    var favoritesCD : FavoritesCDStack
    var mapLocation: MKPlacemark
   
    init( coreDataStack: CoreDataStack = CoreDataStack.shared, favoritesCD: FavoritesCDStack = FavoritesCDStack.shared) {
        self.coreDataStack = coreDataStack
        self.favoritesCD = favoritesCD
        self.mapLocation = MKPlacemark()
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        
        self.mapView = MKMapView(frame: .zero)
        
        self.view.addSubview(self.mapView!)
        self.setupConstraint()
        self.addAllLocation()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fetchResultController : NSFetchedResultsController<WiFiLock> = {
        //fetchRequest — запрос на извлечение объектов NSFetchRequest
        let fetchRequest = NSFetchRequest<WiFiLock>(entityName: "WiFiLock")
        let sortByIndex = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByIndex]
        fetchRequest.fetchBatchSize = 20
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchResultController = NSFetchedResultsController<WiFiLock>(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
        
    }()
    func setupConstraint(){
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0.9).isActive = true
         mapView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         mapView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView?.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func addAllLocation(){
        
        let context = coreDataStack.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WiFiLock")
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [WiFiLock]
                {
                    do
                    {
                        let location = MKPointAnnotation()
                        location.title = result.id
                        location.subtitle = result.psw
                        location.coordinate = CLLocationCoordinate2DMake(Double(result.latitude) ?? 0.0 , Double(result.longtitude) ?? 0.0)
                        mapView!.addAnnotation(location)
                        print("success")
                    }
                }
            }
            try context.save()
        }
        catch { }
    }
}
