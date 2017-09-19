//
//  PictureStorageServices.swift
//  CapProject
//
//  Created by Yveslym on 9/19/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class PictureStorageServices{
    
    static func createProfilePicture(withUserUID UserUID: String = NetworkConstant.currentUserUID!, for image: UIImage){
        
        let randomtitle = randomString.randomString(length: 5)
        let imageRef = Storage.storage().reference().child(Constants.profilePic).child(UserUID).child("\(randomtitle).jpg")
        StorageServices.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
        }
    }
    
}
