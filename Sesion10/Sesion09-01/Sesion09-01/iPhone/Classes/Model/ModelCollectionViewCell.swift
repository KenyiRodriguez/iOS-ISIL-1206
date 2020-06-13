//
//  ModelCollectionViewCell.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/13/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ModelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgModel     : UIImageView!
    @IBOutlet weak var lblModelName : UILabel!
    
    var objModel: Model! {
        didSet{
            self.updateData()
        }
    }
    
    func updateData() {
        
        self.lblModelName.text = self.objModel.model_name ?? ""
        
        let url = self.objModel.model_urlImage ?? ""
        
        self.imgModel.downloadImagenInUrl(url, withPlaceHolderImage: nil) { (urlDownload, imageDownloaded) in
            
            if self.objModel.model_urlImage == urlDownload {
                self.imgModel.image = imageDownloaded
            }
        }
    }
    
    override func awakeFromNib() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
        
        self.contentView.layer.cornerRadius = 10
    }
    
}
