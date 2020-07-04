//
//  LoginViewController.swift
//  Sesion13-01
//
//  Created by Kenyi Rodriguez on 7/4/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUser              : CSMTextField!
    @IBOutlet weak var txtPassword          : CSMTextField!
    @IBOutlet weak var btnLogin             : CSMButton!
    @IBOutlet weak var contentViewField     : CSMShadowView!
    @IBOutlet weak var cnsContentViewField  : NSLayoutConstraint!
    
    var cnsContentViewFieldConstant: CGFloat = 0
    
    @IBAction func clickBtnLogin(_ sender: Any?) {
        
        self.view.endEditing(true)
        
        LoginBL.login(user: self.txtUser.text, password: self.txtPassword.text, success: {
            self.performSegue(withIdentifier: "ProfileViewController", sender: nil)
            
        }) { (errorMessage) in
            self.showAlert(withTitle: "Error", withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
        }
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardSize = keyboardFrame?.size ?? .zero
        let availableHeight = self.view.frame.height - keyboardSize.height - 20
        
        let endPosition_y_contentField = self.contentViewField.frame.origin.y + self.contentViewField.frame.height
        
        if availableHeight < endPosition_y_contentField {
            let delta = endPosition_y_contentField - availableHeight
            UIView.animate(withDuration: 0.35) {
                self.cnsContentViewField.constant = self.cnsContentViewFieldConstant - delta
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        UIView.animate(withDuration: 0.35) {
            self.cnsContentViewField.constant = self.cnsContentViewFieldConstant
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cnsContentViewFieldConstant = self.cnsContentViewField.constant
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.txtUser {
            self.txtPassword.becomeFirstResponder()
            
        }else if textField == self.txtPassword {
            self.clickBtnLogin(nil)
        }
        
        return true
    }
}
