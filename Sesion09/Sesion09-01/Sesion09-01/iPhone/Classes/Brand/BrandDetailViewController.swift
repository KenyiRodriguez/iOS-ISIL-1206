//
//  BrandDetailViewController.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class BrandDetailViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var btnWeb: UIButton!
    
    var objBrand: Brand!
    
    @IBAction func clickBtnWeb(_ sender: Any) {
        
        if let url = URL(string: self.objBrand.brand_web ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            print("NO SE PUEDE ABRIR EL LINK")
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.lblName.text = self.objBrand.brand_name ?? ""
        self.lblOrigin.text = self.objBrand.brand_origin ?? ""
        self.btnWeb.setTitle(self.objBrand.brand_web ?? "Web no disponible", for: .normal)
    }

}
