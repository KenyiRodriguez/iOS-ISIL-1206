//
//  CSMSlider.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 6/24/19.
//

import UIKit

@IBDesignable public class CSMSlider: UISlider {

    @IBInspectable public var thumImage : UIImage?{
        get{
            return self.currentThumbImage
        }set{
            self.setThumbImage(newValue, for: .normal)
            self.setThumbImage(newValue, for: .highlighted)
        }
    }
}
