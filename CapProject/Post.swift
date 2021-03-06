//
//  Post.swift
//  CapProject
//
//  Created by Yves Songolo on 8/8/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class Post: NSObject{
    
    var teacherLastName : String?
    var postDescrition: String?
    var postTitle: String?
    var url: String?
    var date: String?
    var postID:String?
    var postType: String?
    var subType: String?
    var courseID: String?
    
    override init(){
        self.teacherLastName = ""
        self.postID = ""
        self.postType = ""
        self.postTitle = ""
        self.postDescrition = ""
        self.url = ""
        self.date = ""
        self.subType = ""
        self.courseID = ""
        
        
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any]
            
            else{return nil}
        
        
        self.date = dict[Constants.date] as? String
        self.postDescrition = dict[Constants.description] as? String
        self.teacherLastName = dict[Constants.teachers] as? String
        self.postID = dict[Constants.id] as? String
        self.postTitle = dict[Constants.postTitle] as? String
        self.url = dict[Constants.url] as? String
        self.subType = dict[Constants.subType] as? String
        self.postType = dict[Constants.postType] as? String
        self.courseID = dict[Constants.courseID] as? String
    }
    // get post pic
}









