//
//  LogoutViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import TWMessageBarManager
import Firebase
import FirebaseAuth
import Foundation
import GoogleSignIn
import FBSDKLoginKit
class LogoutViewController: UIViewController {

    @IBAction func btnClick(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    func logoutPopup() {
        let alter = UIAlertController(title: "Confirm Logout", message: "Are you suer you want to log out?", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let actionYes = UIAlertAction(title: "Yes", style: .default, handler: {
            [unowned self] action in
            GIDSignIn.sharedInstance().signOut()
            FBSDKLoginManager().logOut()
            try? Auth.auth().signOut()
        })
        alter.addAction(actionCancel)
        alter.addAction(actionYes)
        present(alter, animated: true, completion: nil)
        /*
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: false, completion: nil)
        let mainStoreBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainStoreBoard.instantiateViewController(withIdentifier: "LoginNav")
        UIApplication.shared.keyWindow?.rootViewController = controller
         */
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        logoutPopup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
