//
//  SessionBE.swift
//  Sesion13-01
//
//  Created by Kenyi Rodriguez on 7/4/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class SessionBE: NSObject, NSSecureCoding {
    
    static var shared: SessionBE?
    
    static var supportsSecureCoding: Bool = true
    
    var session_user    : String?
    var session_password: String?
    var session_token   : String?
    
    init(user: String?, password: String?, token: String?) {
        self.session_user = user
        self.session_password = password
        self.session_token = token
    }
    
    //Decode
    required init?(coder: NSCoder) {
        
        self.session_user = coder.decodeObject(forKey: "session_user") as? String ?? ""
        self.session_password = coder.decodeObject(forKey: "session_password") as? String ?? ""
        self.session_token = coder.decodeObject(forKey: "session_token") as? String ?? ""
    }
    
    //Encode
    func encode(with coder: NSCoder) {
        
        coder.encode(self.session_user, forKey: "session_user")
        coder.encode(self.session_password, forKey: "session_password")
        coder.encode(self.session_token, forKey: "session_token")
    }
    
}

/*
 
 UserDefault -> SharePreference (INSEGURO HASTA MAS NO PODER)
 Plist (INSEGURO)
 sQlite, CoreData (MEDIANAMENTE SEGURO)
 KeyChain (NI DIOSITA ENTRA CON DOBLE ENCRIPTACIÓN)
 
 */
