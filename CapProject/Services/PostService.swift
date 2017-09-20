//
//  PostService.swift
//  CapProject
//
//  Created by Yves Songolo on 8/11/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import Firebase

struct PostService {
    
    /// Function to creare an alert
    ///
    /// - Parameters: Post
    ///   - post: post contain: teacher name, post description, date of post
    ///   - completion: completion return Post added in the database
    static func create(course: Course!, post: Post!){
        
        guard let post = post else {return}
        guard let course = course else {return}
        
        let ref = Database.database().reference().child(Constants.post).child(course.courseID!).childByAutoId()
        
        let atts = [Constants.postTitle: post.postTitle,Constants.id: ref.key, Constants.date: Helpers.getTodayString(), Constants.description:post.postDescrition, Constants.teachers: post.teacherLastName, Constants.postType: post.postType, Constants.url : post.url]
        ref.setValue(atts)
    }
   
    static func fetchPosts(withCourseKey key: String, completion: @escaping ([Post]?)->Void){
        let ref = Database.database().reference().child(Constants.post).child(key)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return completion([])}
            
            let posts = snapshot.reversed().flatMap(Post.init)
            
            return completion(posts)
        })
    }
}
























