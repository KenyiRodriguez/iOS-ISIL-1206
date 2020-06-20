//
//  ModelDetailViewController.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/20/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ModelDetailViewController: UIViewController {

    @IBOutlet weak var imgModel         : UIImageView!
    @IBOutlet weak var lblBrandName     : UILabel!
    @IBOutlet weak var lblModelName     : UILabel!
    @IBOutlet weak var lblReleaseYear   : UILabel!
    @IBOutlet weak var lblType          : UILabel!
    
    var objModel: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblModelName.text = self.objModel.model_name ?? ""
        self.lblReleaseYear.text = self.objModel.model_releaseYear ?? ""
        self.lblType.text = self.objModel.model_type ?? ""
        
        self.imgModel.downloadImagenInUrl(self.objModel.model_urlImage ?? "", withPlaceHolderImage: nil) { (_, imageDownloaded) in
            self.imgModel.image = imageDownloaded
        }
        
        self.lblBrandName.text = self.objModel.model_brand?.brand_name ?? ""
    }
}
