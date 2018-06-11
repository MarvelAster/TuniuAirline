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
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var userStorage: StorageReference?
    var userRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        userStorage = Storage.storage().reference()
        userRef = Database.database().reference()
        
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        self.navigationController?.isNavigationBarHidden = true
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
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let _ = error{
            return
        }
        guard let authentication = user.authentication else{
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with:credential){(user, error) in
            if let err = error{
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type:  .error)
            }else{
                FirebaseHandler.sharedInstance.checkIfCurrentUserExistWhenGoogleSignIn(userId: (user?.uid)!, userRef: self.userRef, completion: { (isExist) in
                    if isExist == true{
                        FirebaseHandler.sharedInstance.checkIfUserHasPhotoID(userStorage: self.userStorage, completion: { (doesHavePhotoID) in
                            if doesHavePhotoID == false{
                                let controller = self.storyboard?.instantiateViewController(withIdentifier: "UploadPhotoIDViewController") as! UploadPhotoIDViewController
                                self.navigationController?.present(controller, animated: true, completion: nil)
                            }else{
                                let storyboard =  UIStoryboard(name: "Main", bundle: nil)
                                let rootController = storyboard.instantiateViewController(withIdentifier: "ECSlidingViewController")
                                UIApplication.shared.keyWindow?.rootViewController = rootController
                            }
                        })
                    }else{
                        FirebaseHandler.sharedInstance.googleSignInUploadUserInfo(userId: (user?.uid)!, name: (user?.displayName!)!, email: (user?.email!)!, userRef: self.userRef)
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "UploadPhotoIDViewController") as! UploadPhotoIDViewController
                        self.navigationController?.present(controller, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func googleSignInBtn(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
}
