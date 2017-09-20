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
        let dateFormatter = ISO8601DateFormatter()
        //let randomtitle = randomString.randomString(length: 5)
        let timestamp = dateFormatter.string(from: Date())
        let imageRef = Storage.storage().reference().child(Constants.profilePic).child(UserUID).child("\(timestamp).jpg")
        StorageServices.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
        }
    }
    
}
