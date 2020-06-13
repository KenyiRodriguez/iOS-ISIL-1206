//
//  CSMKeyChain.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 14/03/18.
//

import UIKit

public class CSMKeyChain: NSObject {

    public static var sharedInstance = CSMKeyChain()
    
    public var keychain_deloperMode = true{
        didSet{
            if !self.deviceIsAuthorize() {exit(-1)}
        }
    }
    
    public func dataFromKeychainWithAccount(_ account : String, withService service : String) -> Data? {
        
        if self.deviceIsAuthorize() == true {
            let data = self.keychainDataWithAccount(account, withService: service)
            return data
        }else{
            exit(-1)
        }
    }
    
    @discardableResult public func saveDataInKeychain(_ data : Data, withAccount account : String, withService service : String) -> Bool {
        
        if self.deviceIsAuthorize() == true {
            let saved = self.saveInKeychain(data, withAccount: account, withService: service)
            return saved
        }else{
            exit(-1)
        }
    }
    
    public func deleteKeychain(){
        
        let arrayElementsSecurity = [kSecClassGenericPassword,
                                     kSecClassInternetPassword,
                                     kSecClassCertificate,
                                     kSecClassKey,
                                     kSecClassIdentity]
        
        for elementSecurity in arrayElementsSecurity{
            
            let query = [kSecClass as String : elementSecurity]
            SecItemDelete(query as CFDictionary)
        }
    }
    
    @discardableResult public func deleteKeychainDataWithAccount(_ account : String, withService service : String) -> Bool {
        
        let query = [kSecClass as String                   : kSecClassGenericPassword,
                     kSecAttrAccount as String             : account,
                     kSecAttrService as String             : service,
                     kSecMatchCaseInsensitive as String    : kCFBooleanTrue!,
                     kSecReturnData as String              : kCFBooleanTrue!] as CFDictionary
        
        let status: OSStatus = SecItemDelete(query)
        
        return status == noErr
    }
    
    @discardableResult public func deviceIsAuthorize() -> Bool {
        
        if self.keychain_deloperMode{
            return true
        }
        
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") || FileManager.default.fileExists(atPath: "/bin/bash") || FileManager.default.fileExists(atPath: "/usr/sbin/sshd") || FileManager.default.fileExists(atPath: "/etc/apt") {
            
            return false
            
        }else{
            
            let texto = "1234567890"
            
            do{
                try texto.write(toFile: "/private/cache.txt", atomically: true, encoding: String.Encoding.utf8)
                return false
                
            }catch{
                
                return !UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!)
            }
        }
    }
    
    //MARK: - Privado
    
    private func keychainDataWithAccount(_ account : String, withService service : String) -> Data? {
        
        let query : [String : Any] = [kSecClass as String                   : kSecClassGenericPassword as String,
                                      kSecAttrAccount as String             : account,
                                      kSecAttrService as String             : service,
                                      kSecMatchCaseInsensitive as String    : kCFBooleanTrue!,
                                      kSecReturnData as String              : kCFBooleanTrue!]
        
        var result : AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == noErr && result != nil {
            return result as? Data
        }
        
        return nil
    }
    
    private func saveInKeychain(_ data : Data, withAccount account : String, withService service : String) -> Bool {
        
        let keychainData = data as CFData
        
        let query : [String : Any] = [kSecClass as String            : kSecClassGenericPassword as String,
                                      kSecAttrAccount as String      : account,
                                      kSecAttrService as String      : service,
                                      kSecValueData as String        : keychainData as Data,
                                      kSecAttrAccessible as String   : kSecAttrAccessibleWhenUnlocked as String]
        
        var keychainError = noErr
        keychainError = SecItemAdd(query as CFDictionary, nil)
        
        return keychainError == noErr
    }
}
