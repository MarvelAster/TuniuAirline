//
//  SignInViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor
    }

    @IBAction func signInBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
    }
}
