//
//  ViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 16.07.2021.
//

import UIKit
import Foundation

class LoginFormController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customLoginTextField()
        customPasswordTextField()
        customButtonSignIn()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    func customLoginTextField() {
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.brandGrey])
        loginTextField.clipsToBounds = true
        loginTextField.textColor = UIColor.brandGrey
        loginTextField.roundCorners([.topLeft, .topRight], radius: 8)
        loginTextField.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.5)
    }
    
    func customPasswordTextField() {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.brandGrey])
        passwordTextField.textColor = UIColor.brandGrey
        passwordTextField.roundCorners([.bottomLeft, .bottomRight], radius: 8)
    }
    
    func customButtonSignIn() {
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func IBACtion(_ sender: Any) {
        let login = loginTextField.text
        let password = passwordTextField.text
        
        if login == "admin" && password == "123456" {
            print("It`s okay")
        } else {
            print("It`s bad")
        }
    }
}



