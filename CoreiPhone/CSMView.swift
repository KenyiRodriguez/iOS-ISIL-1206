//
//  CSMView.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 22/03/18.
//

import UIKit

@IBDesignable
public class CSMRadialGradientView: CSMShadowView {

    @IBInspectable public var insideColor : UIColor = UIColor.clear
    @IBInspectable public var outSideColor : UIColor = UIColor.clear
    
    @IBInspectable public var gradiantCenter : CGPoint{
        set(newValue){
            self.internalGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < -1 ? -1 : newValue.x
            self.internalGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < -1 ? -1 : newValue.y
        }
        get{
            return self.internalGradiantCenter
        }
    }
    
    @IBInspectable public var startRadius : CGFloat{
        set(newValue){
            if newValue > 1 {
                self.internalStartRadius = 1
            }else if newValue < 0 {
                self.internalStartRadius = 0
            }else{
                self.internalStartRadius = newValue
            }
        }
        get{
            return self.internalStartRadius
        }
    }
    
    @IBInspectable public var endRadius : CGFloat{
        set(newValue){
            if newValue > 1 {
                self.internalEndRadius = 1
            }else if newValue < 0 {
                self.internalEndRadius = 0
            }else{
                self.internalEndRadius = newValue
            }
        }
        get{
            return self.internalEndRadius
        }
    }
    
    var internalGradiantCenter = CGPoint.zero
    var internalStartRadius : CGFloat = 0
    var internalEndRadius: CGFloat = 0.5
    
    override public func draw(_ rect: CGRect) {
        
        self.createGradientWithStartRadius(self.startRadius, withEndRadius: self.endRadius)        
    }
    
    private func createGradientWithStartRadius(_ startRadius: CGFloat, withEndRadius endRadius: CGFloat){
        
        let colors = [self.insideColor.cgColor, self.outSideColor.cgColor] as CFArray
        
        let endGradientRadius = min(frame.width, frame.height) * endRadius
        let startGradientRadius = min(frame.width, frame.height) * startRadius
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let center = CGPoint(x: width / 2 + (width / 2 * self.gradiantCenter.x), y: height / 2 + (height / 2 * self.gradiantCenter.y))
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()?.drawRadialGradient(gradient!, startCenter: center, startRadius: startGradientRadius, endCenter: center, endRadius: endGradientRadius, options: [.drawsAfterEndLocation , .drawsBeforeStartLocation])
    }
    
    public func animateGradientWithStartRadius(_ startRadius: CGFloat, withEndRadius endRadius: CGFloat){

        UIView.animate(withDuration: 2) {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            
            self.createGradientWithStartRadius(startRadius, withEndRadius: endRadius)
            
            CATransaction.commit()
        }
    }
}

@IBDesignable
public class CSMLinearGradientView: CSMShadowView {
    
    @IBInspectable public var startColor : UIColor = UIColor.clear
    @IBInspectable public var endColor : UIColor = UIColor.clear
    
    @IBInspectable public var startGradiantCenter : CGPoint{
        set(newValue){
            self.internalStartGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < -1 ? -1 : newValue.x
            self.internalStartGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < -1 ? -1 : newValue.y
        }
        get{
            return self.internalStartGradiantCenter
        }
    }
    
    @IBInspectable public var endGradiantCenter : CGPoint{
        set(newValue){
            self.internalEndGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < -1 ? -1 : newValue.x
            self.internalEndGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < -1 ? -1 : newValue.y
        }
        get{
            return self.internalEndGradiantCenter
        }
    }
    
    var internalStartGradiantCenter = CGPoint.zero
    var internalEndGradiantCenter = CGPoint.zero
    
    override public func draw(_ rect: CGRect) {
        
        let colors = [self.startColor.cgColor, self.endColor.cgColor] as CFArray
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let startCenter = CGPoint(x: width / 2 + (width / 2 * self.startGradiantCenter.x), y: height / 2 + (height / 2 * self.startGradiantCenter.y))
        let endCenter = CGPoint(x: width / 2 + (width / 2 * self.endGradiantCenter.x), y: height / 2 + (height / 2 * self.endGradiantCenter.y))
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()?.drawLinearGradient(gradient!, start: startCenter, end: endCenter, options: [.drawsAfterEndLocation , .drawsBeforeStartLocation])
    }
    
    public func updateGradientColor(){
        
        let colors = [self.startColor.cgColor, self.endColor.cgColor] as CFArray
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let startCenter = CGPoint(x: width / 2 + (width / 2 * self.startGradiantCenter.x), y: height / 2 + (height / 2 * self.startGradiantCenter.y))
        let endCenter = CGPoint(x: width / 2 + (width / 2 * self.endGradiantCenter.x), y: height / 2 + (height / 2 * self.endGradiantCenter.y))
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        UIGraphicsGetCurrentContext()?.drawLinearGradient(gradient!, start: startCenter, end: endCenter, options: [.drawsAfterEndLocation , .drawsBeforeStartLocation])
    }
    
}

@IBDesignable
public class CSMLinearThreeColorsGradientView: CSMShadowView {
    
    @IBInspectable public var startColor : UIColor = UIColor.clear
    @IBInspectable public var middleColor : UIColor = UIColor.clear
    @IBInspectable public var endColor : UIColor = UIColor.clear
    
    @IBInspectable public var startGradiantCenter : CGPoint{
        set(newValue){
            self.internalStartGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < 0 ? 0 : newValue.x
            self.internalStartGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < 0 ? 0 : newValue.y
        }
        get{
            return self.internalStartGradiantCenter
        }
    }
    
    @IBInspectable public var endGradiantCenter : CGPoint{
        set(newValue){
            self.internalEndGradiantCenter.x = newValue.x > 1 ? 1 : newValue.x < 0 ? 0 : newValue.x
            self.internalEndGradiantCenter.y = newValue.y > 1 ? 1 : newValue.y < 0 ? 0 : newValue.y
        }
        get{
            return self.internalEndGradiantCenter
        }
    }
    
    var internalStartGradiantCenter = CGPoint.zero
    var internalEndGradiantCenter = CGPoint.zero
    
    override public func draw(_ rect: CGRect) {
        
        let colors = [self.startColor.cgColor, self.middleColor.cgColor]
        
        let gradients = CAGradientLayer()
        gradients.colors = colors
        gradients.frame = self.bounds
        
        gradients.endPoint = self.startGradiantCenter
        gradients.startPoint = self.endGradiantCenter
        
        self.layer.addSublayer(gradients)
    }
    
}

@IBDesignable open class CSMShadowView: UIView{
    
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

@IBDesignable open class CSMShapeView: UIView{
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.internalCornerRadius
        }
        set(newValue){
            self.internalCornerRadius = newValue
            self.layer.cornerRadius = self.internalCornerRadius
        }
    }
    
    @IBInspectable public var borderColor : UIColor{
        get{
            return self.internalBorderColor
        }
        set(newValue){
            self.internalBorderColor = newValue
            self.layer.borderColor = self.internalBorderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat{
        get{
            return self.internalBorderWidth
        }
        set(newValue){
            self.internalBorderWidth = newValue
            self.layer.borderWidth = self.internalBorderWidth
        }
    }
    
    @IBInspectable public var drawBorderLine: Bool = false
    
    @IBInspectable public var lineWidth : Float{
        get{
            return self.internalLineWidth
        }
        set(newValue){
            self.internalLineWidth = newValue
        }
    }
    
    @IBInspectable public var lineSeparator : Float{
        get{
            return self.internalLineSeparator
        }
        set(newValue){
            self.internalLineSeparator = newValue
        }
    }
    
    private var internalCornerRadius    : CGFloat = 0.0
    private var internalBorderColor     = UIColor.clear
    private var internalBorderWidth     : CGFloat = 0.0
    private var internalLineWidth       : Float = 0.0
    private var internalLineSeparator   : Float = 0.0
    
    private var borderLayer = CAShapeLayer()
    
    open override func prepareForInterfaceBuilder() {
        self.setUpLayout()
    }
    
    open override func draw(_ rect: CGRect) {
        self.setUpLayout()
    }
    
    func setUpLayout(){
     
        if self.drawBorderLine {
            self.drawBorderLines()
        }else{
            self.drawSingleBorder()
        }
    }
        
    func drawSingleBorder(){
        
        self.layer.cornerRadius     = self.internalCornerRadius
        self.layer.borderColor      = self.internalBorderColor.cgColor
        self.layer.borderWidth      = self.internalBorderWidth
        self.layer.masksToBounds    = true
        self.clipsToBounds = true
        self.borderLayer.removeFromSuperlayer()
    }
    
    func drawBorderLines(){
        
        self.borderLayer.removeFromSuperlayer()
        self.borderLayer.cornerRadius = self.internalCornerRadius
        self.borderLayer.strokeColor = self.internalBorderColor.cgColor
        self.borderLayer.lineDashPattern = [NSNumber(value: self.internalLineWidth), NSNumber(value: self.internalLineSeparator)]
        self.borderLayer.lineWidth = self.internalBorderWidth
        self.borderLayer.frame = self.bounds
        self.borderLayer.fillColor = nil
        self.borderLayer.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.insertSublayer(self.borderLayer, at: 0)
        
        self.layer.cornerRadius     = self.internalCornerRadius
        self.layer.borderColor      = nil
        self.layer.borderWidth      = 0
        self.layer.masksToBounds    = true
        self.clipsToBounds = true
    }
}


extension UIView {
    
    @IBInspectable public var parallaxEffect : Bool{
        get{
            return Parallax.hasEffect
        }
        set(newValue){
            Parallax.hasEffect = newValue
            
            if Parallax.hasEffect == true {
                self.addMotionEffect(Parallax.effectGroup)
            }else{
                self.removeMotionEffect(Parallax.effectGroup)
            }
        }
    }
    
    @IBInspectable public var minHorizontal : CGFloat{
        get{
            return Parallax.xMotion.minimumRelativeValue as? CGFloat ?? 0.0
        }
        set(newValue){
            Parallax.xMotion.minimumRelativeValue = newValue
            Parallax.effectGroup.motionEffects = [Parallax.xMotion, Parallax.yMotion]
        }
    }
    
    @IBInspectable public var maxHorizontal : CGFloat{
        get{
            return Parallax.xMotion.maximumRelativeValue as? CGFloat ?? 0.0
        }
        set(newValue){
            Parallax.xMotion.maximumRelativeValue = newValue
            Parallax.effectGroup.motionEffects = [Parallax.xMotion, Parallax.yMotion]
        }
    }
    
    @IBInspectable public var minVertical : CGFloat{
        get{
            return Parallax.yMotion.minimumRelativeValue as? CGFloat ?? 0.0
        }
        set(newValue){
            Parallax.yMotion.minimumRelativeValue = newValue
            Parallax.effectGroup.motionEffects = [Parallax.xMotion, Parallax.yMotion]
        }
    }
    
    @IBInspectable public var maxVertical : CGFloat{
        get{
            return Parallax.yMotion.maximumRelativeValue as? CGFloat ?? 0.0
        }
        set(newValue){
            Parallax.yMotion.maximumRelativeValue = newValue
            Parallax.effectGroup.motionEffects = [Parallax.xMotion, Parallax.yMotion]
        }
    }
    
    private struct Parallax {
        
        static var hasEffect    = false
        static let xMotion      = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        static let yMotion      = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        static let effectGroup  = UIMotionEffectGroup()
    }
    
    public func addMotionEffectWithPath(_ path: String, minValue: Any, maxValue: Any, axis: UIInterpolatingMotionEffect.EffectType) {
        
        let motionEffect = UIInterpolatingMotionEffect(keyPath: path, type: .tiltAlongHorizontalAxis)
        motionEffect.minimumRelativeValue = minValue
        motionEffect.maximumRelativeValue = maxValue
        self.addMotionEffect(motionEffect)
        print("\((self.motionEffects.first as? UIInterpolatingMotionEffect)?.keyPath ?? "No HAY")")
    }
    
    public func removeMotionEffectWithPath(_ keyPath : String) {
        self.motionEffects.removeAll(where: {($0 as? UIInterpolatingMotionEffect)?.keyPath == keyPath})
    }
    
    public var parallaxKeys : [String]{
        get{
            return self.motionEffects.map({ "\(($0 as? UIInterpolatingMotionEffect)?.keyPath ?? "")" })
        }
    }
    
}
