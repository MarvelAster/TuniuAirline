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
    
    var userRef : DatabaseReference!
    var airportRef : DatabaseReference!
    var userStorage: StorageReference!
    
    static let sharedInstance = FirebaseHandler()
    
    func databaseInit() {
        userRef = Database.database().reference().child("UserInfo")
        airportRef = Database.database().reference().child("Airport")
        userStorage = Storage.storage().reference()
    }
    
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
    
    func googleSignInUploadUserInfo(userId: String, name: String, email: String, userRef: DatabaseReference?) {
        let dict = ["Email": email, "FullName": name, "UserId": userId, "UserImage": ""]
        userRef?.child("UserInfo").child(userId).updateChildValues(dict)
    }
    
    func checkIfCurrentUserExistWhenGoogleSignIn(userId : String, userRef: DatabaseReference? ,completion :@escaping (Bool) -> Void) {
        userRef?.child(userId).observeSingleEvent(of: .value, with: {
            (snapshot) in
            var result = false
            if (snapshot.value as? Dictionary<String, Any>) != nil {
                result = true
            }
            completion(result)
        })
    }
    
    func downloadUserInfoInProfileViewController(completion:@escaping (String, String, UIImage)->Void) {
        databaseInit()
        userRef.child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of:  .value) { (snapshot) in
            guard let value = snapshot.value as? Dictionary<String, Any> else{
                return
            }
            let name = value["FullName"] as! String
            let email = value["Email"] as! String
            let imagePath = value["UserImage"] as! String
            self.userStorage.child(imagePath).getData(maxSize: 1024*1024*1024, completion: { (data, error) in
                if error != nil{
                    let image = UIImage(named: "userDefaultImage")
                    completion(name, email, image!)
                }else{
                    let image = UIImage(data: data!)
                    completion(name, email, image!)
                }
            })
        }
    }
    
    func uploadUserNameInProfileViewController(name: String) {
        databaseInit()
        let nameDict = ["FullName": name]
        userRef.child((Auth.auth().currentUser?.uid)!).updateChildValues(nameDict)
    }
    
    func uploadUserImageInProfileViewController(image: UIImage) {
        databaseInit()
        let data = UIImagePNGRepresentation(image)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        userStorage?.child("UserImage").child((Auth.auth().currentUser?.uid)!).putData(data!, metadata: metadata, completion: { (meta, error) in
            if let err = error{
                TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type:  .error)
            }
        })
    }
}
