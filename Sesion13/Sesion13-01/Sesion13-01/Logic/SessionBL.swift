//
//  SessionBL.swift
//  Sesion13-01
//
//  Created by Kenyi Rodriguez on 7/4/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

/*
 Guardar
    Convertir a binario
    guardar en keychain
 
 Obtener de keychain
    obtener de keychain (nos regresa un binario)
    convertir binario a clase de SessionBE
 */

class SessionBL {
    
    class func saveSession(_ objSession: SessionBE) -> Bool {
        
        self.closeSession()
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: objSession, requiringSecureCoding: true)
            SessionBE.shared = objSession
            CSMKeyChain.sharedInstance.saveDataInKeychain(data, withAccount: "SessionBE", withService: "session")
            return true
        }catch {
            return false
        }
    }
    
    class func getSession() -> SessionBE? {
        
        guard let session = SessionBE.shared else {
            
            guard let data = CSMKeyChain.sharedInstance.dataFromKeychainWithAccount("SessionBE", withService: "session") else {
                return nil
            }
            
            do{
                let objSession = try NSKeyedUnarchiver.unarchivedObject(ofClass: SessionBE.self, from: data) as SessionBE?
                SessionBE.shared = objSession
                return objSession
            }catch {
                return nil
            }
        }
        
        return session
    }
    
    class func closeSession() {
        
        SessionBE.shared = nil
        CSMKeyChain.sharedInstance.deleteKeychain()
    }
}
