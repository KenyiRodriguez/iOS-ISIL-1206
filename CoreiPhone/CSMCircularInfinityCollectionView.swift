//
//  CSMCircularInfinityCollectionView.swift
//  DemoCollections
//
//  Created by Kenyi Rodriguez on 17/04/18.
//  Copyright © 2018 Kenyi Rodriguez. All rights reserved.
//

import UIKit

public class CSMCircularInfinityCollectionView: UICollectionView {

    public var arrayDataSource: [Any]{
        get{
            return self.internalArrayDataSource
        }
        set{
            self.arrayOriginalEments = newValue
            self.internalArrayDataSource = newValue
            self.addLeftElements()
            self.addRightElements() 
        }
    }
    
    fileprivate var numberOfVisibleCells: CGFloat{
        get{
            let layout : UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
            let sizeCollection = layout.scrollDirection == .horizontal ? self.frame.size.width : self.frame.size.height
            let visibleElements = sizeCollection / (self.sizeCell)
            return ceil(visibleElements)
        }
    }
    
    fileprivate var sizeCell: CGFloat{
        get{
            let layout : UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
            return layout.scrollDirection == .horizontal ? layout.itemSize.width : layout.itemSize.height
        }
    }
    
    fileprivate var contentOffsetValue: CGFloat{
        get{
            
            let layout : UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
            return layout.scrollDirection == .vertical ? contentOffset.y : contentOffset.x
        }
    }
    
    fileprivate var arrayOriginalEments = [Any]()
    fileprivate var internalArrayDataSource = [Any]()
    fileprivate var observerObject : Any?

    
    fileprivate func addRightElements(){
        
        if arrayOriginalEments.count != 0 {
            
            var arrayLeftElements = [Any]()
            var index = 0
            
            repeat{
                arrayLeftElements.append(self.arrayOriginalEments[index])
                index = index + 1 >= arrayOriginalEments.count ? 0 : index + 1
            }while arrayLeftElements.count < Int(self.numberOfVisibleCells)
            
            self.internalArrayDataSource.insert(contentsOf: arrayLeftElements, at: self.internalArrayDataSource.count)
        }
    }
    
    fileprivate func addLeftElements(){
        
        if arrayOriginalEments.count != 0 {
            
            var arrayRightElements = [Any]()
            var index = self.arrayOriginalEments.count - 1
            
            repeat{
                arrayRightElements.insert(self.arrayOriginalEments[index], at: 0)
                index = index - 1 < 0 ? self.arrayOriginalEments.count - 1 : index - 1
            }while arrayRightElements.count < Int(self.numberOfVisibleCells)
            
            self.internalArrayDataSource.insert(contentsOf: arrayRightElements, at: 0)
        }
    }
    
    public override func draw(_ rect: CGRect) {

        super.draw(rect)
        self.observerObject = observe(\.contentOffset, options: [.new]) { (object, change) in
            
            let boundarySize : CGFloat = self.numberOfVisibleCells * (self.sizeCell)
            
            if self.contentOffsetValue >= (self.contentSize.width - boundarySize) {
                let offset = boundarySize
                let updatedOffsetPoint = CGPoint(x: offset, y: 0)
                self.contentOffset = updatedOffsetPoint
            } else if self.contentOffsetValue <= 0 {
                let boundaryLessSize = self.arrayOriginalEments.count * Int(self.sizeCell)
                let updatedOffsetPoint = CGPoint(x: boundaryLessSize, y: 0)
                self.contentOffset = updatedOffsetPoint
            }
        }
        
    }
    
    
    public func goInitialItemList(){
        
        let indexPath = IndexPath(item: Int(self.numberOfVisibleCells), section: 0)
        self.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.left, animated: false)
    }
    
    deinit {
        
        if let observer = self.observerObject{
            NotificationCenter.default.removeObserver(observer)
        }
        
    }
}


