//
//  CSMLabel.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 10/2/18.
//

import UIKit

@IBDesignable public class CSMLabel: UILabel{
    
    @IBInspectable public var shadowColorLabel : UIColor{
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
    
    @IBInspectable public var shadowOffsetLabel : CGSize{
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
    
    @IBInspectable public var spaceLine : CGFloat{
        get{
            return self.internalSpaceLine
        }
        set(newValue){
            self.internalSpaceLine = newValue
            self.setSpaceLineInText()
        }
    }
    
    @IBInspectable public var paddingTop : CGFloat{
        get{
            return self.paddingInsets.top
        }
        set(newValue){
            self.paddingInsets.top = newValue
        }
    }
    
    @IBInspectable public var paddingBottom : CGFloat{
        get{
            return self.paddingInsets.bottom
        }
        set(newValue){
            self.paddingInsets.bottom = newValue
        }
    }
    
    @IBInspectable public var paddingLeft : CGFloat{
        get{
            return self.paddingInsets.left
        }
        set(newValue){
            self.paddingInsets.left = newValue
        }
    }
    
    @IBInspectable public var paddingRight : CGFloat{
        get{
            return self.paddingInsets.right
        }
        set(newValue){
            self.paddingInsets.right = newValue
        }
    }
    
    fileprivate var paddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    fileprivate var internalSpaceLine : CGFloat = 0.0
    
    fileprivate func setSpaceLineInText(){
        
        let labelText = self.text ?? ""
        let alignText = self.textAlignment
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = self.internalSpaceLine
        paragraphStyle.alignment = alignText
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layer.shadowColor      = self.shadowColorLabel.cgColor
        self.layer.shadowOffset     = self.shadowOffsetLabel
        self.layer.shadowRadius     = self.shadowRadius
        self.layer.shadowOpacity    = self.shadowOpacity
        self.layer.cornerRadius     = self.cornerRadius
        self.layer.borderColor      = self.borderColor.cgColor
        self.layer.borderWidth      = self.borderWidth
        self.layer.masksToBounds    = false
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.paddingInsets))
    }
    
    public override var intrinsicContentSize: CGSize {
        get{
            var contentSize = super.intrinsicContentSize
            contentSize.height += self.paddingInsets.top + self.paddingInsets.bottom
            contentSize.width += self.paddingInsets.left + self.paddingInsets.right
            return contentSize
        }
    }
}
