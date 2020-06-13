//
//  CSMLocalAuthentication.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 7/5/18.
//

import UIKit
import LocalAuthentication

public enum CSMLAError : String {
    case appCancel              = "El proceso de autenticación fué cancelado por la aplicación."
    case authenticationFailed   = "La autenticación ingresada es incorrecta."
    case invalidContext         = "El contexto de la autenticación es invá lido."
    case passcodeNotSet         = "No tienes una clave de seguridad configurada en tu dispositivo."
    case systemCancel           = "El proceso de autenticación fué cancelado por el sistema."
    case biometryLockout        = "Se superó el número de intentos de autenticación."
    case biometryNotAvailable   = "La autenticación biométrica no esta disponible en este dispositivo."
    case biometryNotEnrolled    = "Aun no registra una clave biométrica en este dispositivo."
    case userCancel             = "El proceso fué cancelado."
    case userFallback           = "El proceso de autenticación está intentando usar el respaldo de iCloud."
    case none                   = "El proceso de autenticación está temporalmente fuera de servicio."
    
}

public extension UIViewController{

    func verifyLocalAuthenticationWith(reason: String, withSuccess success: @escaping ()->Void, withFailure failure: @escaping (_ errorMessage: String, _ laError: CSMLAError)->Void){
        
        let contexto = LAContext()
     
        if contexto.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            
            contexto.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (isSuccess, error) in
                
                DispatchQueue.main.async{
                    
                    if isSuccess {
                        success()
                    }else{
                        let csmError = self.errorMessageFor(errorCode: (error as NSError?)?.code ?? -1)
                        failure(csmError.rawValue, csmError)
                    }
                    
                }
                
            }

        }else{
            failure(CSMLAError.passcodeNotSet.rawValue, .passcodeNotSet)
        }
    }
    
    private func errorMessageFor(errorCode: Int) -> CSMLAError {
    
        switch Int32(errorCode) {
        case kLAErrorAppCancel:
            return CSMLAError.appCancel
        case kLAErrorAuthenticationFailed:
            return CSMLAError.authenticationFailed
        case kLAErrorInvalidContext:
            return CSMLAError.invalidContext
        case kLAErrorPasscodeNotSet:
            return CSMLAError.passcodeNotSet
        case kLAErrorSystemCancel:
            return CSMLAError.systemCancel
        case kLAErrorTouchIDLockout:
            return CSMLAError.biometryLockout
        case kLAErrorBiometryNotAvailable:
            return CSMLAError.biometryNotAvailable
        case kLAErrorBiometryNotEnrolled:
            return CSMLAError.biometryNotEnrolled
        case kLAErrorUserCancel:
            return CSMLAError.userCancel
        case kLAErrorUserFallback:
            return CSMLAError.userFallback
        default:
            return CSMLAError.none
        }
    }
}
