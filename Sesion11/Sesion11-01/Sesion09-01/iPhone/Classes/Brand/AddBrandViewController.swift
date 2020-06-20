//
//  AddBrandViewController.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AddBrandViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtOrigin: UITextField!
    @IBOutlet weak var txtWeb: UITextField!
    
    @IBAction func clickBtnAddBrand(_ sender: Any) {
        
        let name = self.txtName.text
        let origin = self.txtOrigin.text
        let web = self.txtWeb.text

        BrandBL.create(name: name, origin: origin, web: web, success: { (objBrand) in
            print("Se guardo correctamente")
            self.navigationController?.popViewController(animated: true)
            
        }) { (errorMessage) in
         
            self.showAlert(withTitle: "Error", withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
            
//            let alertAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
//
//            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
//            alertController.addAction(alertAction)
//
//            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
