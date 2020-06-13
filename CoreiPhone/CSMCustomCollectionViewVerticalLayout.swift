//
//  CSMCustomCollectionViewVerticalLayout.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 5/15/19.
//

import UIKit


@objc public protocol CSMCustomCollectionViewHorizontalLayoutDelegate {
    
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, widthForItemAtIndexPath indexPath: IndexPath, toHeightCell heightCell: CGFloat) -> CGFloat
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, paddingForSection section: Int) -> UIEdgeInsets
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, horizontalItemSeparatorForSection section: Int) -> CGFloat
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, verticalItemSeparatorForSection section: Int) -> CGFloat
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, newSizeForContent size: CGSize)
    @objc optional func customCollectionViewHorizontalLayout(_ viewLayout: CSMCustomCollectionViewHorizontalLayout, heightToCellForSection section: Int) -> Int
}

@IBDesignable public class CSMCustomCollectionViewHorizontalLayout: UICollectionViewLayout {
    
    @IBOutlet public var delegate  : CSMCustomCollectionViewHorizontalLayoutDelegate?
    
    @IBInspectable public var horizontalInset : CGFloat{
        get{
            return self.internalHorizontalInset ?? 0
        }set{
            self.internalHorizontalInset = newValue
        }
    }
    
    @IBInspectable public var verticalInset : CGFloat{
        get{
            return self.internalVerticalInset ?? 0
        }set{
            self.internalVerticalInset = newValue
        }
    }
    
    @IBInspectable public var heightCell : Int{
        get{
            return self.internalHeightCell ?? 1
        }set{
            self.internalHeightCell = newValue
        }
    }
    
    private var internalHorizontalInset : CGFloat?
    private var internalVerticalInset   : CGFloat?
    private var internalHeightCell : Int?
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    private var contentSize             = CGSize.zero
    
    func getIndexWithMinorHeightInArray(_ array: [CGPoint]) -> Int {
        
        let arraySort = array.sorted(by: {$0.y < $1.y})
        guard let first = arraySort.first else { return 0 }
        return array.firstIndex(of: first) ?? 0
    }
    
    func getIndexWithMajorHeightInArray(_ array: [CGPoint]) -> Int {
        
        let arraySort = array.sorted(by: {$0.y > $1.y})
        guard let first = arraySort.first else { return 0 }
        return array.firstIndex(of: first) ?? 0
    }
    
    override public func prepare() {
        
        super.prepare()
        
        self.cache.removeAll()
        guard cache.isEmpty == true,let collectionView = self.collectionView else { return }
        
        var yOffset : CGFloat = 0
        var xOffset : CGFloat = 0
        
        for section in 0..<(collectionView.numberOfSections){
            
            let horizontalInset = self.internalHorizontalInset  ?? self.delegate?.customCollectionViewHorizontalLayout?(self, horizontalItemSeparatorForSection: section) ?? 10
            let verticalInset   = self.internalVerticalInset    ?? self.delegate?.customCollectionViewHorizontalLayout?(self, verticalItemSeparatorForSection: section) ?? 10
            let heightCell      = self.internalHeightCell       ?? self.delegate?.customCollectionViewHorizontalLayout?(self, heightToCellForSection: section) ?? 1
            let inset           = self.delegate?.customCollectionViewHorizontalLayout?(self, paddingForSection: section) ?? .zero
            let heightForHeader = self.delegate?.customCollectionViewHorizontalLayout?(self, heightForHeaderInSection: section) ?? 0
            let heightForFooter = self.delegate?.customCollectionViewHorizontalLayout?(self, heightForFooterInSection: section) ?? 0
            
            yOffset = yOffset + inset.top + heightForHeader
            xOffset = inset.left
            
            var itemSize = CGSize.zero
            
            for item : Int in 0 ..< collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let widthCell = self.delegate?.customCollectionViewHorizontalLayout?(self, widthForItemAtIndexPath: indexPath, toHeightCell: CGFloat(heightCell)) ?? 0
                itemSize = CGSize(width: Int(widthCell), height: heightCell)
                
                let newWidth = xOffset + itemSize.width
                let availableWidth = collectionView.frame.size.width - inset.right
                
                if newWidth <= availableWidth {
                    attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                    xOffset += (itemSize.width + horizontalInset)
                }else{
                    
                    yOffset += (itemSize.height + verticalInset)
                    xOffset = inset.left
                    attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                    xOffset += (itemSize.width + horizontalInset)
                }
            
                self.cache.append(attributes)
            }
            
            yOffset += CGFloat(heightCell) + inset.bottom + heightForFooter
        }
        
        self.contentSize = CGSize(width: collectionView.frame.size.width, height: yOffset)
        self.delegate?.customCollectionViewHorizontalLayout?(self, newSizeForContent: self.contentSize)
    }
    
    override public var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
            
        }
        return visibleLayoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.item]
    }
}


@objc public protocol CSMCustomCollectionViewVerticalLayoutDelegate {
    
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, heightForItemAtIndexPath indexPath: IndexPath, toWidthCell widthCell: CGFloat) -> CGFloat
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, paddingForSection section: Int) -> UIEdgeInsets
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, horizontalItemSeparatorForSection section: Int) -> CGFloat
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, verticalItemSeparatorForSection section: Int) -> CGFloat
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, newSizeForContent size: CGSize)
    @objc optional func customCollectionViewVerticalLayout(_ viewLayout: CSMCustomCollectionViewVerticalLayout, numberOfColumnsForSection section: Int) -> Int
}

@IBDesignable public class CSMCustomCollectionViewVerticalLayout: UICollectionViewLayout {
    
    @IBOutlet public var delegate  : CSMCustomCollectionViewVerticalLayoutDelegate?
    
    @IBInspectable public var horizontalInset : CGFloat{
        get{
            return self.internalHorizontalInset ?? 0
        }set{
            self.internalHorizontalInset = newValue
        }
    }
    
    @IBInspectable public var verticalInset : CGFloat{
        get{
            return self.internalVerticalInset ?? 0
        }set{
            self.internalVerticalInset = newValue
        }
    }
    
    @IBInspectable public var numberOfColumns : Int{
        get{
            return self.internalNumberOfColumns ?? 1
        }set{
            self.internalNumberOfColumns = newValue
        }
    }
    
    private var internalHorizontalInset : CGFloat?
    private var internalVerticalInset   : CGFloat?
    private var internalNumberOfColumns : Int?
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    private var contentSize             = CGSize.zero
    
    func getIndexWithMinorHeightInArray(_ array: [CGPoint]) -> Int {
        
        let arraySort = array.sorted(by: {$0.y < $1.y})
        guard let first = arraySort.first else { return 0 }
        return array.firstIndex(of: first) ?? 0
    }
    
    func getIndexWithMajorHeightInArray(_ array: [CGPoint]) -> Int {
        
        let arraySort = array.sorted(by: {$0.y > $1.y})
        guard let first = arraySort.first else { return 0 }
        return array.firstIndex(of: first) ?? 0
    }
    
    override public func prepare() {
        
        super.prepare()
        
        self.cache.removeAll()
        guard cache.isEmpty == true,let collectionView = self.collectionView else { return }
        
//        self.layoutAttributes = Dictionary<String, UICollectionViewLayoutAttributes>()
        var yOffset : CGFloat = 0
        
        for section in 0..<(collectionView.numberOfSections){
            
            let horizontalInset = self.internalHorizontalInset  ?? self.delegate?.customCollectionViewVerticalLayout?(self, horizontalItemSeparatorForSection: section) ?? 10
            let verticalInset   = self.internalVerticalInset    ?? self.delegate?.customCollectionViewVerticalLayout?(self, verticalItemSeparatorForSection: section) ?? 10
            let numberOfColumns = self.internalNumberOfColumns  ?? self.delegate?.customCollectionViewVerticalLayout?(self, numberOfColumnsForSection: section) ?? 1
            let inset           = self.delegate?.customCollectionViewVerticalLayout?(self, paddingForSection: section) ?? .zero
            let heightForHeader = self.delegate?.customCollectionViewVerticalLayout?(self, heightForHeaderInSection: section) ?? 0
            let heightForFooter = self.delegate?.customCollectionViewVerticalLayout?(self, heightForFooterInSection: section) ?? 0
            let columnWidth     = (collectionView.frame.width - inset.left - inset.right - (horizontalInset * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
            
            yOffset = yOffset + inset.top + heightForHeader
            
            var itemSize = CGSize.zero
            var arrayPositions = [CGPoint]()
            
            for column in 0..<numberOfColumns {
                arrayPositions.append(CGPoint(x: inset.left + (columnWidth + horizontalInset) * CGFloat(column), y: yOffset))
            }
            
            for item : Int in 0 ..< collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let heightCell = self.delegate?.customCollectionViewVerticalLayout?(self, heightForItemAtIndexPath: indexPath, toWidthCell: columnWidth) ?? 0
                itemSize = CGSize(width: columnWidth, height: heightCell)
                
                let currentIndexColumn = self.getIndexWithMinorHeightInArray(arrayPositions)
                attributes.frame = CGRect(x: arrayPositions[currentIndexColumn].x, y: arrayPositions[currentIndexColumn].y, width: itemSize.width, height: itemSize.height).integral
                
                arrayPositions[currentIndexColumn].y = arrayPositions[currentIndexColumn].y + attributes.frame.height + verticalInset
                
                self.cache.append(attributes)
            }
            
            let columnMajorHeightIndex = self.getIndexWithMajorHeightInArray(arrayPositions)
            
            yOffset = arrayPositions[columnMajorHeightIndex].y + inset.bottom + heightForFooter
        }
        
        self.contentSize = CGSize(width: collectionView.frame.size.width, height: yOffset)
        self.delegate?.customCollectionViewVerticalLayout?(self, newSizeForContent: self.contentSize)
    }
    
    override public var collectionViewContentSize: CGSize {
        return self.contentSize
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
            
        }
        return visibleLayoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.item]
    }
    

}
