//
//  AlbumCollectionViewCell.swift
//  Sesion11-02
//
//  Created by Kenyi Rodriguez on 6/20/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var objAlbum: AlbumBE! {
        didSet{
            self.updateData()
        }
    }
    
    func updateData() {
        self.lblName.text = self.objAlbum.album_name
        self.imgAlbum.downloadImagenInUrl(self.objAlbum.album_urlImage, withPlaceHolderImage: nil) { (urlDownload, imageDownloaded) in
            
            if self.objAlbum.album_urlImage == urlDownload {
                self.imgAlbum.image = imageDownloaded
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        self.contentView.layer.cornerRadius = 10
    }
}
