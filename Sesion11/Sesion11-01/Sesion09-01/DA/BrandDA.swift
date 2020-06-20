//
//  BrandDA.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation
import CoreData

class BrandDA {
    
    class func create(name: String, origin: String, web: String, context: NSManagedObjectContext) -> Brand {
        
        let objDM = NSEntityDescription.insertNewObject(forEntityName: "Brand", into: context) as! Brand
        
        objDM.brand_name = name
        objDM.brand_origin = origin
        objDM.brand_web = web
        
        return objDM
    }
    
    class func listAll(context: NSManagedObjectContext) -> [Brand] {
        
        let fetchRequest: NSFetchRequest<Brand> = Brand.fetchRequest()
    
        let sortName    = NSSortDescriptor(key: "brand_name", ascending: true)
        fetchRequest.sortDescriptors = [sortName]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        }catch {
            return []
        }
    }
    
    class func listAllBySearchKey(searchKey: String, context: NSManagedObjectContext) -> [Brand] {
        
        let fetchRequest: NSFetchRequest<Brand> = Brand.fetchRequest()
    
        let predicate = NSPredicate(format: "brand_name contains[c] %@ OR brand_origin contains[c] %@", searchKey, searchKey)
        fetchRequest.predicate = predicate
        
        let sortName    = NSSortDescriptor(key: "brand_name", ascending: true)
        fetchRequest.sortDescriptors = [sortName]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        }catch {
            return []
        }
    }
}
