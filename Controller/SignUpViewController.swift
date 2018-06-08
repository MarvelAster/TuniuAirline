//
//  SignUpViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import TWMessageBarManager
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var userRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userRef = Database.database().reference().child("UserInfo")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text != confirmEmailTextField.text{
            confirmEmailTextFieldShake()
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            confirmPasswordTextFieldShake()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.text != confirmEmailTextField.text{
            confirmEmailTextFieldShake()
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            confirmPasswordTextFieldShake()
        }
        return true
    }
    

    @IBAction func signUpBtnAction(_ sender: UIButton) {
        if emailTextField.text == confirmEmailTextField.text && passwordTextField.text == confirmPasswordTextField.text{
            FirebaseHandler.sharedInstance.uploadUserInfo(userRef: userRef, name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, completion:{() in
                self.navigationController?.popViewController(animated: true)
            })
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please confirm your email or password again", preferredStyle:  .alert)
            let okAction = UIAlertAction(title: "OK", style:  .default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style:  .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }
    
    func confirmEmailTextFieldShake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: confirmEmailTextField.center.x - 4.0, y: confirmEmailTextField.center.y)
        animation.toValue = CGPoint(x: confirmEmailTextField.center.x + 4.0, y: confirmEmailTextField.center.y)
        confirmEmailTextField.layer.add(animation, forKey: "position")
    }
    
    func confirmPasswordTextFieldShake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: confirmPasswordTextField.center.x - 4.0, y: confirmPasswordTextField.center.y)
        animation.toValue = CGPoint(x: confirmPasswordTextField.center.x + 4.0, y: confirmPasswordTextField.center.y)
        confirmPasswordTextField.layer.add(animation, forKey: "position")
    }
    
}
