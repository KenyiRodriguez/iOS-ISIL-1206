//
//  ModelDA.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation
import CoreData

/*
Select
From *
Where
Order by
*/

class ModelDA {
    
    class func create(name: String, releaseYear: String, type: String, urlImage: String, context: NSManagedObjectContext) -> Model {
        
        let objDM = NSEntityDescription.insertNewObject(forEntityName: "Model", into: context) as! Model
        
        objDM.model_name = name
        objDM.model_releaseYear = releaseYear
        objDM.model_type = type
        objDM.model_urlImage = urlImage
        
        return objDM
    }
    
    class func listAll(context: NSManagedObjectContext) -> [Model] {
        
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
    
        let sortName        = NSSortDescriptor(key: "model_name", ascending: true)
        let sortReleaseYear = NSSortDescriptor(key: "model_releaseYear", ascending: true)
        fetchRequest.sortDescriptors = [sortReleaseYear, sortName]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        }catch {
            return []
        }
    }
    
    class func listAllBySearchKey(searchKey: String, context: NSManagedObjectContext) -> [Model] {
        
        let fetchRequest: NSFetchRequest<Model> = Model.fetchRequest()
    
        let predicate = NSPredicate(format: "model_name contains[c] %@ OR model_type contains[c] %@", searchKey, searchKey)
        fetchRequest.predicate = predicate
        
        let sortName        = NSSortDescriptor(key: "model_name", ascending: true)
        let sortReleaseYear = NSSortDescriptor(key: "model_releaseYear", ascending: true)
        fetchRequest.sortDescriptors = [sortReleaseYear, sortName]
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        }catch {
            return []
        }
    }
}
