//
//  MapViewService.swift
//  FINAL Project
//
//  Created by Katherine on 09/12/2019.
//  Copyright © 2019 Katherine123. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class MapService {
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    ///достает данные о точках из core data
    internal func addAllLocation() -> [MKPointAnnotation]{
        let context = coreDataStack.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WiFiLock")
        var locations = [MKPointAnnotation]()
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                guard let results = (results as? [WiFiLock]) else {
                    fatalError()
                }
                for result in results
                {
                    do
                    {
                        let location = MKPointAnnotation()
                        location.title = result.id
                        location.subtitle = result.psw
                        location.coordinate = CLLocationCoordinate2DMake(Double(result.latitude) ?? 0.0 , Double(result.longtitude) ?? 0.0)
                        locations.append(location)
                        print("success")
                    }
                }
            }
            try context.save()
        }
        catch { }
        return locations
    }
}
