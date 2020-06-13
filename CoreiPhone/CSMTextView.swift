//
//  CSMTextField.swift
//  CoreSoleraMobile
//
//  Created by Paul Aguilar on 4/3/18.
//  Copyright © 2018 aguilarpgc. All rights reserved.
//

//#if os(iOS)
import  UIKit
//#endif

@IBDesignable
public class CSMTextView: UITextView {
    
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
    
    @IBInspectable public var topMargin : CGFloat{
        get{
            return self.edgeMargin.top
        }
        set(newValue){
            self.edgeMargin.top = newValue
        }
    }
    
    @IBInspectable public var leftMargin : CGFloat{
        get{
            return self.edgeMargin.left
        }
        set(newValue){
            self.edgeMargin.left = newValue
        }
    }
    
    @IBInspectable public var rightMargin : CGFloat{
        get{
            return self.edgeMargin.right
        }
        set(newValue){
            self.edgeMargin.right = newValue
        }
    }
    
    @IBInspectable public var bottomMargin : CGFloat{
        get{
            return self.edgeMargin.bottom
        }
        set(newValue){
            self.edgeMargin.bottom = newValue
        }
    }
    
    private var edgeMargin : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    @IBInspectable public var counterColor: UIColor = .black {
        didSet {
            updateCounter()
        }
    }
    @IBInspectable public var isCounterVisible: Bool = false {
        didSet {
            updateCounter()
        }
    }
    @IBInspectable public var isCounterAscending: Bool = false {
        didSet {
            updateCounter()
        }
    }
    @IBInspectable public var maxCharacters: UInt = 0 {
        didSet {
            updateCounter()
        }
    }
    @IBInspectable public var placeholderText: String = "" {
        didSet {
            updatePlaceholder()
        }
    }
    @IBInspectable public var placeholderColor: UIColor = .darkGray {
        didSet {
            updatePlaceholder()
        }
    }
    
    override public var font: UIFont! {
        didSet {
            updatePlaceholder()
        }
    }
    
    override public var text: String! {
        didSet {
            textChanged()
        }
    }
    
    public var placeholderFont: UIFont? {
        didSet {
            if let placeholderFont = placeholderFont {
                placeholderLabel.font = placeholderFont
            }
        }
    }
    
    public var counterFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            counterLabel.font = counterFont
        }
    }
    
    // MARK: - Lazy Properties -
    
    private lazy var placeholderLabel: UILabel = {
        
        let label = UILabel()
        label.font = self.font
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.text = self.placeholderText
        label.textAlignment = .left
        self.addSubview(label)
        
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        
        let counterFrame = CGRect(
            x: self.bounds.size.width - 40.0,
            y: self.bounds.size.height - 30.0,
            width: 30.0,
            height: 20.0
        )
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = self.font
        label.frame = counterFrame
        label.text = "\(self.maxCharacters)"
        label.textAlignment = .center
        self.addSubview(label)
        
        return label
    }()
    
    // MARK: - Initializer -
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        firstSetup()
        updateAll()
        self.contentInset = self.edgeMargin
    }
    
    // MARK: - Setup -
    
    private func firstSetup() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.textChanged),
            name: UITextView.textDidChangeNotification,
            object: nil)
    }
    
    // MARK: - Methods -
    
    @objc private func textChanged() {
        
        placeholderLabel.isHidden = !text.isEmpty
        
        if maxCharacters > 0 && isCounterVisible {
            
            if self.text.count > maxCharacters {
                
                let range = self.text.startIndex..<self.text.index(self.text.startIndex, offsetBy: Int(maxCharacters))
                let tempText = self.text[range]
                self.text = String(tempText)
            }
            
            updateCounterTracking()
        }
    }
    
    // MARK: - Update -
    
    private func updateAll() {
        
        updateCounter()
        updateCounterFrame()
        updatePlaceholder()
        
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    private func updatePlaceholder() {
        
        let placeholderFrame = CGRect(
            x: self.textContainerInset.left + self.textContainer.lineFragmentPadding,
            y: self.textContainerInset.top + 0.5,
            width: self.bounds.size.width - (self.textContainerInset.left + self.textContainerInset.right),
            height: self.bounds.size.height - (self.textContainerInset.top + self.textContainerInset.bottom))
        
        if let placeholderFont = self.placeholderFont {
            
            placeholderLabel.font = placeholderFont
        }
        
        placeholderLabel.frame = placeholderFrame
        placeholderLabel.text = placeholderText
        placeholderLabel.textAlignment = self.textAlignment
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
    }
    
    private func updateCounterFrame() {
        
        let counterFrame = CGRect(
            x: self.bounds.size.width - 40.0,
            y: self.bounds.size.height - 30.0,
            width: 30.0,
            height: 20.0
        )
        
        counterLabel.frame = counterFrame
    }
    
    private func updateCounter() {
        
        counterLabel.font = counterFont
        counterLabel.textColor = counterColor
        
        guard maxCharacters > 0 && isCounterVisible else {
            counterLabel.isHidden = true
            return
        }
        
        counterLabel.isHidden = false
        updateCounterTracking()
    }
    
    private func updateCounterTracking() {
        
        if isCounterAscending {
            counterLabel.text = "\(self.text.count)"
        } else {
            counterLabel.text = "\(Int(maxCharacters) - self.text.count)"
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

