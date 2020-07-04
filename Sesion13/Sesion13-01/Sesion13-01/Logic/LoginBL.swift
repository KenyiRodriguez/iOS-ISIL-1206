//
//  LoginBL.swift
//  Sesion13-01
//
//  Created by Kenyi Rodriguez on 7/4/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class LoginBL {
    
    typealias Success = () -> Void
    typealias ErrorMessage = (_ errorMessage: String) -> Void
    
    class func login(user: String?, password: String?, success: @escaping Success, errorMessage: @escaping ErrorMessage) {
        
        guard let safeUser = user, safeUser.count != 0 else {
            errorMessage("Ingrese un usuario válido")
            return
        }
        
        guard let safePassword = password, safePassword.count != 0 else {
            errorMessage("Ingrese un password válido")
            return
        }
        
        let objSession = SessionBE(user: safeUser, password: safePassword, token: "asdf34567hjrt")
        
        if SessionBL.saveSession(objSession) {
            success()
        }else{
            errorMessage("No se pudo completar la sesión")
        }
    }
}
