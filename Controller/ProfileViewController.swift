//
//  ProfileViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirebaseHandler.sharedInstance.downloadUserInfoInProfileViewController{ (name, email, image) in
            self.accountLabel.text = email
            self.userImage.image = image
            self.nameTextField.text = name
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        FirebaseHandler.sharedInstance.uploadUserNameInProfileViewController(name: textField.text!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            userImage.image = pickedImage
            FirebaseHandler.sharedInstance.uploadUserImageInProfileViewController(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageBtnAction(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        if imagePicker.sourceType ==  .camera{
            imagePicker.sourceType =  .camera
        }else{
            imagePicker.sourceType =  .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func btnClick(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }


}
