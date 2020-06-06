//
//  BrandBL.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation
import UIKit

class BrandBL {
    
    typealias Create = (_ objBrand: Brand) -> Void
    typealias ErrorMessage = (_ errorMessage: String) -> Void
    
    class func create(name: String?, origin: String?, web: String?, success: Create, error: ErrorMessage) {
        
        guard let safeName = name else {
            error("Ingresa un nombre correcto.")
            return
        }
        
        guard let safeOrigin = origin else {
            error("Ingresa un país de origen correcto.")
            return
        }
        
        guard let safeWeb = web else {
            error("Ingresa una web correcta.")
            return
        }
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        
        let objDM = BrandDA.create(name: safeName, origin: safeOrigin, web: safeWeb, context: context)
        appDelegateInstance.saveContext()
        success(objDM)
    }
    
    class func listAll() -> [Brand] {
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        return BrandDA.listAll(context: context)
    }
    
    class func listAllBySearchKey(searchKey: String) -> [Brand] {
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        return BrandDA.listAllBySearchKey(searchKey: searchKey, context: context)
    }
    
    class func delete(_ objModel: Brand) {
        
        let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegateInstance.persistentContainer.viewContext
        context.delete(objModel)
        appDelegateInstance.saveContext()
    }
    
}
