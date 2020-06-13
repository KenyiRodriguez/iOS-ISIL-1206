//
//  CSMSearchBar.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 1/9/19.
//

import UIKit

@IBDesignable public class CSMSearchBar: UISearchBar {

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
    
    @IBInspectable public var iconSearch: UIImage?{
        get{
            let textField = self.value(forKey: "searchField") as? UITextField
            return (textField?.leftView as? UIImageView)?.image
        }
        set{
            let textField = self.value(forKey: "searchField") as? UITextField
            (textField?.leftView as? UIImageView)?.image = newValue
        }
    }
    
    @IBInspectable public var iconClear: UIImage?{
        get{
            let textField = self.value(forKey: "searchField") as? UITextField
            let clearButton = textField?.value(forKey: "clearButton") as? UIButton
            return clearButton?.imageView?.image
        }
        set{
            let textField = self.value(forKey: "searchField") as? UITextField
            let clearButton = textField?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable public var textColor: UIColor?{
        get{
            let textField = self.value(forKey: "searchField") as? UITextField
            return textField?.textColor
        }
        set{
            let textField = self.value(forKey: "searchField") as? UITextField
            textField?.textColor = newValue
        }
    }
    
    @IBInspectable public var placeHolderColor: UIColor?{
        get{
            let textField = self.value(forKey: "searchField") as? UITextField
            let textFieldLabel = textField?.value(forKey: "placeholderLabel") as? UILabel
            return textFieldLabel?.textColor
        }
        set{
            let textField = self.value(forKey: "searchField") as? UITextField
            let textFieldLabel = textField?.value(forKey: "placeholderLabel") as? UILabel
            textFieldLabel?.textColor = newValue
        }
    }
    
    public var font: UIFont?{
        get{
            let textField = self.value(forKey: "searchField") as? UITextField
            return textField?.font
        }
        set{
            let textField = self.value(forKey: "searchField") as? UITextField
            textField?.font = newValue
//            let textFieldLabel = textField?.value(forKey: "placeholderLabel") as? UILabel
//            textFieldLabel?.font = newValue
        }
    }
    
    override public func draw(_ rect: CGRect) {
        
        super.draw(rect)
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
    
}
