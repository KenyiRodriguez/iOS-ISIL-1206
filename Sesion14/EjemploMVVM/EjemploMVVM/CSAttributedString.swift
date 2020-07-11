//
//  CSAttributedString.swift
//  CoreSoleraUtilities
//
//  Created by Kenyi Rodriguez on 1/17/20.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    public func getSizeToWidth(_ width: CGFloat) -> CGSize {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil).size
    }
    
    public func getSizeToHeight(_ height: CGFloat) -> CGSize {
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return self.boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil).size
    }
    
    public class func createWith(text: String, font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize), color: UIColor = .black, lineSpacing: CGFloat = 0) -> NSAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        
        let dicAttributes = [NSAttributedString.Key.font : font,
                             NSAttributedString.Key.foregroundColor : color,
                             NSAttributedString.Key.paragraphStyle: style]
        
        
        let attribute = NSAttributedString(string: text, attributes: dicAttributes)
        return attribute
    }
}

extension NSMutableAttributedString {
    
    public func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        
        let range = NSRange(location: 0, length: self.string.count)
        self.addAttribute(key, value: value, range: range)
    }
    
    public func removeAttribute(_ key: NSAttributedString.Key) {
        
        let range = NSRange(location: 0, length: self.string.count)
        self.removeAttribute(key, range: range)
    }
    
    public func addMiddleline(_ add: Bool, color: UIColor? = nil) {
        
        let keyStyle = NSAttributedString.Key.strikethroughStyle
        let value = NSUnderlineStyle.single.rawValue
        add ? self.addAttribute(keyStyle, value: value) : self.removeAttribute(keyStyle)
        
        guard let color = color else { return }
        let keyColor = NSAttributedString.Key.strikethroughColor
        add ? self.addAttribute(keyColor, value: color) : self.removeAttribute(keyColor)
    }
    
    public func addUnderline(_ add: Bool, color: UIColor? = nil) {
        
        let key = NSAttributedString.Key.underlineStyle
        let value = NSUnderlineStyle.single.rawValue
        add ? self.addAttribute(key, value: value) : self.removeAttribute(key)
        
        guard let color = color else { return }
        let keyColor = NSAttributedString.Key.underlineColor
        add ? self.addAttribute(keyColor, value: color) : self.removeAttribute(keyColor)
    }
    
    public func setLineSpacing(_ lineSpacing: CGFloat) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let key = NSAttributedString.Key.paragraphStyle
        self.addAttribute(key, value: paragraphStyle)
    }
}
