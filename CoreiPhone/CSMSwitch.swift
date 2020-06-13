//
//  CSMSwitch.swift
//  CoreSoleraMobile
//
//  Created by Felix Chacaltana on 1/22/19.
//

import UIKit

@IBDesignable class CSMSwitch: UISwitch {
    
    var viewBackground  = UIView()
    var imageView       = UIImageView()
    
    var onColor         : UIColor?
    var offColor        : UIColor?
    var img             : UIImage?
    
    @IBInspectable public var imageForView: UIImage?{
        get{
            if let image = self.img {
                return image
            } else {
                return nil
            }
        }
        set(newValue){
            self.img = newValue
            self.imageView.image = self.img
        }
    }
    
    @IBInspectable public var onBackgroundColor: UIColor{
        get{
            if let color = self.onColor {
                return color
            } else {
                return UIColor.black
            }
        }
        set(newValue){
            self.onColor = newValue
            self.viewBackground.backgroundColor = self.isOn ? self.onColor : self.offColor
        }
    }
    
    @IBInspectable public var offBackgroundColor: UIColor{
        get{
            if let color = self.offColor {
                return color
            } else {
                return UIColor.black
            }
        }
        set(newValue){
            self.offColor = newValue
            self.viewBackground.backgroundColor = self.isOn ? self.onColor : self.offColor
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.viewBackground.layer.cornerRadius
        }
        set(newValue){
            self.viewBackground.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var borderColor : UIColor{
        get{
            if let color = self.viewBackground.layer.borderColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.white
            }
        }
        set(newValue){
            self.viewBackground.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat{
        get{
            return self.viewBackground.layer.borderWidth
        }
        set(newValue){
            self.viewBackground.layer.borderWidth = newValue
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.replacingViews()
        self.updateSwitchViews()
    }
    
    override func layoutSubviews() {
        self.imageView.image       = self.img
        self.imageView.contentMode = .center
    }
    
    // MARK: - Private Functions
    
    private func replacingViews() {
        
        let subviews = self.subviews
        let mainView = subviews.first
        
        for subView in mainView?.subviews ?? [] {
            
            if subView is UIImageView{
                self.imageView = subView as! UIImageView
            }else{
               subView.removeFromSuperview()
            }
        }
        
        self.addTarget(self, action: #selector(self.toggle), for: UIControl.Event.valueChanged)
        
        mainView?.addSubview(self.viewBackground)
        mainView?.bringSubviewToFront(self.imageView)
    }
    
    private func updateSwitchViews() {
        
        self.viewBackground.frame               = self.bounds
        self.viewBackground.backgroundColor     = self.isOn ? self.onColor : self.offColor
        self.viewBackground.layer.borderWidth   = self.borderWidth
        self.viewBackground.layer.borderColor   = self.borderColor.cgColor
        self.viewBackground.layer.cornerRadius  = self.cornerRadius
        self.viewBackground.layer.masksToBounds = false
    }
    
    @objc private func toggle() {
        
        UIView.animate(withDuration: 0.25) {
            self.viewBackground.backgroundColor = self.isOn ? self.onColor : self.offColor
        }
    }
}
