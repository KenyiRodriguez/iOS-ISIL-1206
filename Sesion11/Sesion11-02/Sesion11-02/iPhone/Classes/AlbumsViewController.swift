//
//  AlbumsViewController.swift
//  Sesion11-02
//
//  Created by Kenyi Rodriguez on 6/20/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var clvAlbums: UICollectionView!
    
    var arrayAlbums = [AlbumBE]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AlbumBL.getAlbums { (arrayAlbums) in
            self.arrayAlbums = arrayAlbums
            self.clvAlbums.reloadData()
        }
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "AlbumCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
        cell.objAlbum = self.arrayAlbums[indexPath.row]
        return cell
    }
}

extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 2
        let paddingLeft: CGFloat = 20
        let paddingRight: CGFloat = 20
        let spacingCell: CGFloat = 20
        let avaibleSize = collectionView.frame.width - paddingLeft - paddingRight - (spacingCell * (numberOfColumns - 1))
        let cellWidth = avaibleSize / numberOfColumns
        let cellHeight = cellWidth * 1.5
        
        let newSize = CGSize(width: cellWidth, height: cellHeight)
        return newSize
    }
}
