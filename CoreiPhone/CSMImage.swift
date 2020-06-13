//
//  Extension+UIImage.swift
//  BeneficiosBCP
//
//  Created by Mateo Thomas Espinoza Saavedra on 14/11/17.
//  Copyright © 2018 Kenyi Rodriguez. All rights reserved.
//

import UIKit

public extension UIImage {

    func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat(Double.pi / 180))
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat(Double.pi / 180)))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func tintWithColor(color:UIColor)->UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        if let context = UIGraphicsGetCurrentContext(), let newCgImage = self.cgImage  {
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -self.size.height)
            context.setBlendMode(.multiply)
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            context.clip(to: rect, mask: newCgImage)
            
            color.setFill()
            context.fill(rect)
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }else{
            return nil
        }
    }
    
    func tintWithColor(startColor: UIColor, endColor: UIColor)->UIImage? {
        
        let width = self.size.width
        let height = self.size.height
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, self.scale)
        
        if let context = UIGraphicsGetCurrentContext(), let newCgImage = self.cgImage  {
            
            context.translateBy(x: 0, y: height)
            context.scaleBy(x: 1, y: -1)
            context.setBlendMode(.normal)
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            context.draw(newCgImage, in: rect)
            
            let colors = [endColor.cgColor, startColor.cgColor] as CFArray
            
            let space = CGColorSpaceCreateDeviceRGB()
            let startCenter = CGPoint(x: width / 2 + (width / 2 * 0), y: height / 2 + (height / 2 * -1))
            let endCenter = CGPoint(x: width / 2 + (width / 2 * 0), y: height / 2 + (height / 2 * 1))
            let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)
            
            context.clip(to: rect, mask: newCgImage)
            context.drawLinearGradient(gradient!, start: startCenter, end: endCenter, options: [.drawsAfterEndLocation , .drawsBeforeStartLocation])
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }else{
            return nil
        }
    }
}
