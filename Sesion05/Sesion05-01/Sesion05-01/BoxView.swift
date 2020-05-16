//
//  BoxView.swift
//  Sesion05-01
//
//  Created by Kenyi Rodriguez on 5/16/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

protocol BoxViewDelegate {
    func boxView(_ view: BoxView, didTapGesture tapGesture: UITapGestureRecognizer)
}

class BoxView: UIView {
    
    var delegate: BoxViewDelegate?
    
    override func draw(_ rect: CGRect) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureInView(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureInView(_ tapGesture: UITapGestureRecognizer) {
        self.delegate?.boxView(self, didTapGesture: tapGesture)
    }
    
    func animateState() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            
            self.setRandomBackgroundColor()
            self.setRandomCenter()
            self.changeAngleRotation()
            
        }) { (_) in
            
            self.resetAngleRotation()
            print("TERMINO DE ANIMAR")
        }
    }
    
    func changeAngleRotation() {
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 1.5, y: 1.5)
    }
    
    func resetAngleRotation() {
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
    
    func setRandomCenter() {
        
        let minx = self.frame.width / 2
        let maxx = (self.superview?.frame.width ?? 0) - self.frame.width / 2
        let posx = CGFloat.random(in: minx...maxx)
        
        let miny = self.frame.height / 2
        let maxy = (self.superview?.frame.height ?? 0) - self.frame.height / 2
        let posy = CGFloat.random(in: miny...maxy)
        
        self.center = CGPoint(x: posx, y: posy)
    }
    
    func setRandomBackgroundColor() {
                
        let r = CGFloat.random(in: 0...255) / 255.0
        let g = CGFloat.random(in: 0...255) / 255.0
        let b = CGFloat.random(in: 0...255) / 255.0
        
        self.backgroundColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
    }
}
