//
//  UploadPhotoIDViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class UploadPhotoIDViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var userStorage: StorageReference?
    var userRef: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        userStorage = Storage.storage().reference()
        userRef = Database.database().reference()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            userImageView.image = pickedImage
            FirebaseHandler.sharedInstance.uploadUserImage(userStorage: userStorage, userRef: userRef, image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func changeImageBtnAction(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        if imagePicker.sourceType ==  .camera{
            imagePicker.sourceType =  .camera
        }else{
            imagePicker.sourceType =  .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard.instantiateViewController(withIdentifier: "ECSlidingViewController")
        UIApplication.shared.keyWindow?.rootViewController = rootController
    }
}
