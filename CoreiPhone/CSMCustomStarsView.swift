//
//  CustomStarsView.swift
//  CoreSoleraMobile
//
//  Created by Gabriel Castillo on 4/3/18.
//  Copyright © 2018 Solera Mobile. All rights reserved.
//

import UIKit

@objc public protocol CSMCustomStarsViewDelegate {
    
    @objc optional func customStarsView(_ starView: CSMCustomStarsView, makeRatingWithValue value: Double)
}

@IBDesignable public class CSMCustomStarsView: UIView {

    lazy var viewColor : UIView = {
        
        let _viewColor = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.bounds.height))
        _viewColor.backgroundColor = self.starsColorSelected
        return _viewColor
    }()
    
    @IBOutlet public var delegate : CSMCustomStarsViewDelegate?
    
    override public func draw(_ rect: CGRect) {
        
        self.backgroundColor = starsColor
        
        self.addSubview(self.viewColor)
        
        for btn in self.arrayStars{
            self.addSubview(btn)
        }
        
        self.setupGesture()
    }
    
    func setupGesture() {
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(gestureAction(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    
    @objc func gestureAction(_ gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: self)
        self.viewColor.frame = CGRect(x: 0, y: 0, width: location.x, height: self.bounds.size.height)
        let value = (Double(location.x) / Double(self.widthOfStar))
        if  0 <= value && value <= Double(self.numberOfStars) {
            self.delegate?.customStarsView?(self, makeRatingWithValue: Double(round(100*value)/100))
        }
        
        
    }
    
    @IBInspectable public var numberOfStars   : Int = 5
    @IBInspectable public var starsSelected   : Int = 0 {
        didSet{
            guard 0...self.numberOfStars ~= self.starsSelected else {
                return
            }
            self.colorOfStarsSelected()
        }
    }

    @IBInspectable public var widthOfStar     : Int = 50 {
        didSet{
            self.updateFrameStars()
        }
    }
    
    @IBInspectable public var heightOfStar    : Int = 50 {
        didSet{
            self.updateFrameStars()
        }
    }
    
    @IBInspectable public var separatorOfStar : Int = 10 {
        didSet{
            self.updateFrameStars()
        }
    }
    
    @IBInspectable public var starsColor      : UIColor = .white{
        didSet{
            for btn in self.arrayStars{
                btn.backgroundColor = self.starsColor
            }
        }
    }
    
    @IBInspectable public var starsColorSelected : UIColor = .orange{
        didSet{
            for btn in self.arrayStars{
                btn.backgroundColor = self.starsColorSelected
            }
        }
    }
    
    
    @IBInspectable public var starImage       : UIImage = UIImage(){
        didSet{
            for btn in self.arrayStars{
                btn.setBackgroundImage(self.starImage, for: .normal)
                btn.setBackgroundImage(self.starImage, for: .highlighted)
            }
        }
    }
    
    lazy public var arrayStars : [UIButton] = {
        
        var _arrayStars = [UIButton]()
        for tag in 0..<self.numberOfStars {
            let delta : CGFloat = self.frame.size.width/2 - CGFloat((self.widthOfStar+self.separatorOfStar)*self.numberOfStars/2)
            let rect = CGRect(x: Int(delta) + tag*(self.widthOfStar+self.separatorOfStar) , y: Int(self.frame.height/2) - self.heightOfStar/2, width: self.widthOfStar, height: self.heightOfStar)
            let btn = self.createStarWith(frame: rect, tag: tag)
            _arrayStars.append(btn)
        }
        return _arrayStars
    }()
    
    func createStarWith(frame: CGRect, tag: Int) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.tag = tag + 1
        btn.backgroundColor = self.starsColor
        btn.frame = frame
        btn.addTarget(self, action: #selector(self.clickBtnStar(_:)), for: .touchUpInside)
        btn.setBackgroundImage(self.starImage, for: .normal)
        btn.setBackgroundImage(self.starImage, for: .highlighted)
        return btn
    }
    
    @objc fileprivate func clickBtnStar(_ sender: UIButton) {
        self.starsSelected = sender.tag
        self.colorOfStarsSelected()
        let value = Double(sender.tag)
        self.delegate?.customStarsView?(self, makeRatingWithValue: value)
    }
    
    fileprivate func colorOfStarsSelected() {
        let yes = CGRect(x: 0, y: 0, width: self.widthOfStar*self.starsSelected, height: Int(self.bounds.height))
        self.viewColor.frame = yes
    }
    
    fileprivate func updateFrameStars() {
        for tag in 0..<self.numberOfStars{
            let delta : CGFloat = self.frame.size.width/2 - CGFloat((self.widthOfStar+self.separatorOfStar)*self.numberOfStars/2)
            let rect = CGRect(x: Int(delta) + tag*(self.widthOfStar+self.separatorOfStar), y: Int(self.frame.height/2) - self.heightOfStar/2, width: self.widthOfStar, height: self.heightOfStar)
            let btn = self.arrayStars[tag]
            btn.frame = rect
        }
    }

}
