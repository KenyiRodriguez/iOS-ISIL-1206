//
//  CSMColorManager.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 14/03/18.
//

import UIKit
import Foundation

public extension UIColor {
    
    private class func intFromHexString(_ hexString: String) -> UInt32{
        
        var hexInt : UInt32 = 0
        
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet.init(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        
        return hexInt
    }
    
    class func colorFromHexString(_ hexString: String, withAlpha alpha: CGFloat) -> UIColor {
        
        let hexint = self.intFromHexString(hexString)
        
        let red = CGFloat((hexint & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hexint & 0xFF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func toHexString() -> String {
        
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb : Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format: "%06x", rgb)
    }
    
}
