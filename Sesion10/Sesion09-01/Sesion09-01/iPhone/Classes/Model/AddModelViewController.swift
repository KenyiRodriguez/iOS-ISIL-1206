//
//  AddModelViewController.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/13/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AddModelViewController: UIViewController {

    @IBOutlet weak var txtName          : UITextField!
    @IBOutlet weak var txtReleaseYear   : UITextField!
    @IBOutlet weak var txtType          : UITextField!
    @IBOutlet weak var txtUrlImage      : UITextField!
    
    var objBrand: Brand!
    
    @IBAction func clickBtnAddModel(_ sender: Any) {
        
        let name        = self.txtName.text
        let releaseYear = self.txtReleaseYear.text
        let type        = self.txtType.text
        let urlImage    = self.txtUrlImage.text
        
        ModelBL.create(name: name, releaseYear: releaseYear, type: type, urlImage: urlImage, success: { (objModelAdded) in
            
            ModelBL.insertModel(objModelAdded, inBrand: self.objBrand)
            self.navigationController?.popViewController(animated: true)
            
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
