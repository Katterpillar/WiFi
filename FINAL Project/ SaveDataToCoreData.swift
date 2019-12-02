////
////  AddUsersLocation.swift
////  Wi-Fi_Map
////
////  Created by Katherine on 26/11/2019.
////  Copyright © 2019 Katherine123. All rights reserved.
////
//import UIKit
//import CoreData
//
//class SaveDataToCoreData {
//    
//
//    let stack = CoreDataStack.shared
//    
//   
//    func refreshData(){
//        
//        //Referring to the app delegate
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        //IS a manger that allows us to work with CoreData
//        let context = appDelegate.persistentContainer.viewContext
//        //Retrieve USERS
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WiFiLock")
//        
//        do
//        {
//            let results = try context.fetch(request)
//            
//            if results.count > 0
//            {
//                for result in results as! [NSManagedObject]
//                {
//                    
//                    do
//                    {
//                        context.delete(result)
//                        print("success")
//                    }
//                    
//                }
//            }
//            try context.save()
//        }
//        catch
//        {
//            
//        }
//        
//    }
//
//    func saveFromNW(){
//        self.refreshData()
//        network.loadList { (list) in
//            
//            for i in 0..<list.count  {
//                let data = list[i]
//                self.saveUsersLocation(data: data)
//                print("suxxess")
//            }
//        }
//    }
//    
//}
