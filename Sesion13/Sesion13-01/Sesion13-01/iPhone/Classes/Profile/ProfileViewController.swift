//
//  ProfileViewController.swift
//  Sesion13-01
//
//  Created by Kenyi Rodriguez on 7/4/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBAction func clickBtnCloseSession(_ sender: Any) {
        
        SessionBL.closeSession()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let objSession = SessionBL.getSession() {
            print("Usuario: \(objSession.session_user ?? "Sin usuario")")
            print("Password: \(objSession.session_password ?? "Sin password")")
        }
    }
}
