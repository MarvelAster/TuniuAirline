//
//  FirebaseHandler.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import TWMessageBarManager
import FirebaseAuth
import FirebaseStorage

final class FirebaseHandler{
    static let sharedInstance = FirebaseHandler()
    
    private init(){
        
    }
    func uploadUserInfo(userRef:DatabaseReference? ,name: String, email: String, password: String, completion:@escaping ()->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error{
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
            }else{
                let curUser = Auth.auth().currentUser
                let userDict = ["FullName": name, "Email": email, "UserId": curUser?.uid, "UserImage": ""]
                userRef?.child((curUser?.uid)!).updateChildValues(userDict)
                completion()
            }
        }
    }
    
    func checkIfUserHasPhotoID(userStorage: StorageReference?, completion: @escaping (Bool)->Void) {
        var doesHavePhotoID = true
        userStorage?.child("UserImage").child((Auth.auth().currentUser?.uid)!).getData(maxSize: 1024*1024*1024, completion: { (data, error) in
            if error != nil{
                doesHavePhotoID = false
                completion(doesHavePhotoID)
            }else{
                doesHavePhotoID = true
                completion(doesHavePhotoID)
            }
        })
    }
    
    func uploadUserImage(userStorage: StorageReference?, userRef: DatabaseReference?, image: UIImage) {
        let data = UIImagePNGRepresentation(image)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        userStorage?.child("UserImage").child((Auth.auth().currentUser?.uid)!).putData(data!, metadata: metadata, completion: { (meta, error) in
            if let err = error{
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type:  .error)
            }
        })
        let userImageDict = ["UserImage": "UserImage/\((Auth.auth().currentUser?.uid)!)"]
        userRef?.child("UserInfo").child((Auth.auth().currentUser?.uid)!).updateChildValues(userImageDict)
    }
}
