//
//  ModelBL.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class ModelBL {
    
    typealias Create = (_ objModel: Model) -> Void
    typealias ErrorMessage = (_ errorMessage: String) -> Void
    
    class func create(name: String?, releaseYear: String?, type: String?, urlImage: String?, success: Create, error: ErrorMessage) {
        
        guard let safeName = name else {
            error("Ingresa un nombre correcto.")
            return
        }
        
        guard let safeReleaseYear = releaseYear else {
            error("Ingresa un año de fabricación correcto.")
            return
        }
        
        guard let safeType = type else {
            error("Ingresa un tipo correcto.")
            return
        }
        
        guard let safeUrlImage = urlImage else {
            error("Ingresa un link correcto.")
            return
        }
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        
        let objDM = ModelDA.create(name: safeName, releaseYear: safeReleaseYear, type: safeType, urlImage: safeUrlImage, context: context)
        appDelegateInstance.saveContext()
        success(objDM)
    }
    
    class func listAll() -> [Model] {
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        return ModelDA.listAll(context: context)
    }
    
    class func listAllBySearchKey(searchKey: String) -> [Model] {
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        return ModelDA.listAllBySearchKey(searchKey: searchKey, context: context)
    }
    
    class func delete(_ objModel: Model) {
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        context.delete(objModel)
        appDelegateInstance.saveContext()
    }
    
    class func insertModel(_ objModel: Model, inBrand objBrand: Brand) {
        
        objBrand.addToBrand_models(objModel)
        objModel.model_brand = objBrand
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        appDelegateInstance.saveContext()
    }
}
