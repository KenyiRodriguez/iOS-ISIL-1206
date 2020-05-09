//
//  ViewController.swift
//  Sesion04-01
//
//  Created by Kenyi Rodriguez on 5/9/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollContent            : UIScrollView!
    @IBOutlet weak var bottonConstraintScroll   : NSLayoutConstraint!
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        UIView.animate(withDuration: 0.3) {
            self.bottonConstraintScroll.constant = keyboardFrame.size.height
            self.view.layoutIfNeeded()
        }
    
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        UIView.animate(withDuration: 0.3) {
            self.bottonConstraintScroll.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func goToEndScroll() {
        
        let heightScroll = self.scrollContent.frame.size.height
        let heightContent = self.scrollContent.contentSize.height
        
        let finalPosY = heightContent - heightScroll
        let point = CGPoint(x: 0, y: finalPosY)
        self.scrollContent.setContentOffset(point, animated: true)
    }
    
}


































