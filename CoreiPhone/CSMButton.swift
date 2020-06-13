//
//  CSMButton.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 23/03/18.
//

import UIKit

@IBDesignable public class CSMButton: UIButton {

    @IBInspectable public var shadowColor : UIColor{
        get{
            if let color = self.layer.shadowColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.black
            }
        }
        set(newValue){
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var shadowOffset : CGSize{
        get{
            return self.layer.shadowOffset
        }
        set(newValue){
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable public var shadowRadius : CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set(newValue){
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable public var shadowOpacity : Float{
        get{
            return self.layer.shadowOpacity
        }
        set(newValue){
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var borderColor : UIColor{
        get{
            if let color = self.layer.borderColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }
        set(newValue){
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat{
        get{
            return self.layer.borderWidth
        }
        set(newValue){
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var underLineText : Bool{
        get{
            return self.internalUnderLineText
        }
        set(newValue){
            self.internalUnderLineText = newValue
            self.createUnderlineText()
        }
    }
    
    @IBInspectable public var spaceLine : CGFloat{
        get{
            return self.internalSpaceLine
        }
        set(newValue){
            self.internalSpaceLine = newValue
            self.setSpaceLineInText()
        }
    }
    
    @IBInspectable public var gradientStartColor : UIColor?
    @IBInspectable public var gradientEndColor : UIColor?
    
    fileprivate var internalUnderLineText = false
    fileprivate var internalSpaceLine   : CGFloat = 0.0
    
    fileprivate func setSpaceLineInText(){
        
        let labelText = self.titleLabel?.text ?? ""
        let alignText = self.titleLabel?.textAlignment ?? .left
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = self.internalSpaceLine
        paragraphStyle.alignment = alignText
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.titleLabel?.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.titleLabel?.attributedText = attributedString
    }
    
    fileprivate func createUnderlineText(){
    
        let textContent = self.titleLabel?.text ?? ""
        
        let attributedString = NSMutableAttributedString(string: textContent)
        let range = NSRange(location: 0, length: self.internalUnderLineText ? textContent.count : 0)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        self.titleLabel?.attributedText = attributedString
    }
    
//    public override func draw(_ rect: CGRect) {
    
 
//    }
    
    private lazy var gradiant: CAGradientLayer = {
       
        let gradiant = CAGradientLayer()
        gradiant.locations = [0.0, 1.0]
        gradiant.cornerRadius = self.cornerRadius
        gradiant.masksToBounds = false
        self.layer.insertSublayer(gradiant, at: 0)
        return gradiant
    }()
    
    public func updateGradientColor(){
        
        if let starColor = self.gradientStartColor, let endColor = self.gradientEndColor{
            
            self.gradiant.frame = self.bounds
            self.gradiant.colors = [starColor.cgColor, endColor.cgColor]
            self.layoutIfNeeded()
        }
    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
    
        self.layer.shadowColor      = self.shadowColor.cgColor
        self.layer.shadowOffset     = self.shadowOffset
        self.layer.shadowRadius     = self.shadowRadius
        self.layer.shadowOpacity    = self.shadowOpacity
        self.layer.cornerRadius     = self.cornerRadius
        self.layer.borderColor      = self.borderColor.cgColor
        self.layer.borderWidth      = self.borderWidth
        self.layer.masksToBounds    = false
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.updateGradientColor()
    }

}
