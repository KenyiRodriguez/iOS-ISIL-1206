//
//  BrandTableViewCell.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    
    var objBrand: Brand!{
        didSet{
            self.updateData()
        }
    }
    
    func updateData() {
        
        self.lblName.text = self.objBrand.brand_name ?? ""
        self.lblOrigin.text = self.objBrand.brand_origin ?? ""
    }
}
