//
//  CSMNumber.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 19/09/18.
//

import UIKit

extension Int{
    
    public func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, locale: Locale = Locale.init(identifier: "es_PE")) -> String {
        let num = NSNumber(value: self)
        let formater = NumberFormatter()
        formater.numberStyle = numberStyle
        formater.locale = locale
        return formater.string(from: num) ?? ""
    }
}

extension Double{
    
    public func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, locale: Locale = Locale.init(identifier: "es_PE")) -> String {
        
        let num = NSNumber(value: self)
        let formater = NumberFormatter()
        formater.numberStyle = numberStyle
        formater.locale = locale
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
        formater.roundingMode = .up
        return formater.string(from: num) ?? "" 
    }
}
