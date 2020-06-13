//
//  CSMPageControl.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 9/30/19.
//

import UIKit

@IBDesignable public class CSMPageControl: UIPageControl {

    @IBInspectable public var iconActive: UIImage?{
        get{
            return self.internalIconActive
        }
        set{
            self.internalIconActive = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable public var iconInactive: UIImage?{
        get{
            return self.internalIconInactive
        }
        set{
            self.internalIconInactive = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    @IBInspectable public var colorActive: UIColor?{
        get{
            return self.internalColorActive
        }
        set{
            self.internalColorActive = newValue
            self.updateDots()
        }
    }
    
    @IBInspectable public var colorInactive: UIColor?{
        get{
            return self.internalColorInactive
        }
        set{
            self.internalColorInactive = newValue
            self.updateDots()
        }
    }
    
    public override var currentPage: Int{
        didSet{
            self.updateDots()
        }
    }
    
    private var internalColorActive     : UIColor?
    private var internalColorInactive   : UIColor?
    private var internalIconActive      : UIImage?
    private var internalIconInactive    : UIImage?
    
    func updateDots() {
        for (index, view) in self.subviews.enumerated() {
            if let imageView = self.imageForSubview(view) {
                imageView.image = index == self.currentPage ? self.internalIconActive : self.internalIconInactive
                imageView.tintColor = index == self.currentPage ? self.internalColorActive : self.internalColorInactive
            } else {
                let dotImage = index == self.currentPage ? self.internalIconActive?.withRenderingMode(.alwaysTemplate) : self.internalIconInactive?.withRenderingMode(.alwaysTemplate)
                view.clipsToBounds = false
                let img = UIImageView(image:dotImage)
                img.tintColor = index == self.currentPage ? self.internalColorActive : self.internalColorInactive
                view.addSubview(img)
            }
        }
    }
    
    private func imageForSubview(_ view:UIView) -> UIImageView? {
        
        var dot:UIImageView?
        
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        
        return dot
    }
    
    public override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        self.updateDots()
    }
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        self.updateDots()
    }
  
}
