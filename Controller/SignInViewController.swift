//
//  SignInViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import TWMessageBarManager
import FirebaseAuth
import FirebaseStorage

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var userStorage: StorageReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userStorage = Storage.storage().reference()
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func signInBtnAction(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if let err = error{
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
            }else{
                FirebaseHandler.sharedInstance.checkIfUserHasPhotoID(userStorage: self.userStorage, completion: { (doesHavePhotoID) in
                    if doesHavePhotoID == false{
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "UploadPhotoIDViewController") as! UploadPhotoIDViewController
                        //self.navigationController?.pushViewController(controller, animated: true)
                        self.navigationController?.present(controller, animated: true, completion: nil)
                    }else{
                        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
                        let rootController = storyboard.instantiateViewController(withIdentifier: "ECSlidingViewController")
                        UIApplication.shared.keyWindow?.rootViewController = rootController
                    }
                })
            }
        }
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
    }
}
