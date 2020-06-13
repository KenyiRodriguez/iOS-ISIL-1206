//
//  ListModelViewController.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ListModelViewController: UIViewController {

    @IBOutlet weak var clvModel: UICollectionView!
    
    var objBrand: Brand!
    var arrayModel = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.arrayModel = self.objBrand.brand_models?.allObjects as? [Model] ?? []
        self.clvModel.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension ListModelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "ModelCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ModelCollectionViewCell
        cell.objModel = self.arrayModel[indexPath.row]
        return cell
    }
}

extension ListModelViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let countColums: CGFloat = 1
        let collectionWidth = collectionView.frame.width
        let paddingLeft: CGFloat = 20
        let paddingRight: CGFloat = 20
        let spacingColumns = 20 * (countColums - 1)
        
        let cellWidth = (collectionWidth - paddingLeft - paddingRight - spacingColumns) / countColums
        let cellHeight = cellWidth * 0.6
        
        let newSize = CGSize(width: cellWidth, height: cellHeight)
        return newSize
    }
}
