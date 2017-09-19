//
//  StorageServices.swift
//  CapProject
//
//  Created by Yveslym on 9/19/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageServices{
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // 1
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        // 2
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // 4
            completion(metadata?.downloadURL())
        })
    }
    
}
