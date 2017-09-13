//
//  loginNetwork.swift
//  CapProject
//
//  Created by Yves Songolo on 7/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuth.FIRUser
import Firebase
import UIKit

struct NetworkConstant
{
    
    static let currentUserUID = Auth.auth().currentUser?.uid
    static let rootRef        = Database.database().reference()
    static let teacherRef     = Database.database().reference().child(Constants.teachers).child((NetworkConstant.currentUserUID)!)
    static let teacherInfoRef = NetworkConstant.teacherRef.child(Constants.info)
    static let postRef = NetworkConstant.rootRef.child(Constants.post)
    static let alertPosttRef  = NetworkConstant.postRef.child(Constants.postAlert)
    static let AssignmentPostRef = NetworkConstant.postRef.child(Constants.AssigmentPost)
    static let generalInfoPostRef = NetworkConstant.postRef.child(Constants.generalInfoPost)
    
    //==> Mark Student update
    
    
    struct Student{
        static let studentRef     = Database.database().reference().child(Constants.student).child((NetworkConstant.currentUserUID)!)
        static let studentInfoRef = NetworkConstant.Student.studentRef.child(Constants.info)
        static let studentCourseRef =  NetworkConstant.Student.studentRef.child(Constants.course)
        
        static func UpdatephoneNumber(withNumber number: Int){
            NetworkConstant.Student.studentInfoRef.updateChildValues([Constants.phoneNumber:number])
        }
        
        static func UpdateUsername(withUsername username: String){
            NetworkConstant.Student.studentInfoRef.updateChildValues([Constants.username:username])
        }
        
        static func UpdateFirstName(firstName: String!){
            NetworkConstant.Student.studentInfoRef.updateChildValues([Constants.firstName: firstName])
        }
        
        static func UpdateLastName(lastName: String!){
            NetworkConstant.Student.studentInfoRef.updateChildValues([Constants.lastName: lastName])
        }
        
        static func UpdateLevel(level: String!){
            NetworkConstant.Student.studentInfoRef.updateChildValues([Constants.level: level])
        }
    }
    
    //==> Mark Teacher Update
    struct Teacher {
    static func updateUsername(withUsername username: String){
        NetworkConstant.teacherInfoRef.updateChildValues([Constants.username:username])
    }
    
    static func updateNumber(withNumber number: Int){
        NetworkConstant.teacherInfoRef.updateChildValues([Constants.phoneNumber:number])
    }
        static func updateFirstName(firstname: String!){
            NetworkConstant.teacherInfoRef.updateChildValues([Constants.firstName: firstname])
        }
        static func updateLastName(lastname: String!){
            NetworkConstant.teacherInfoRef.updateChildValues([Constants.lastName:lastname])
        }
        
    }
    
    //==> Mark: course ref
    
    struct course {
        static let courseRef = Database.database().reference().child(Constants.course)
        static let courseInfoRef = NetworkConstant.course.courseRef.child(Constants.courseInfo)
        static let attendenceRef = NetworkConstant.course.courseRef.child(Constants.attendance)
    }
    
    
    //==> Mark: attendance ref
    
    struct attencace {
       
        
        /// function that return the attendance ref
        /// P.S: THE FUNCTION DOESN'T TAKE THE ATTENDANCE KEY,
        /// ATTENDANCE KEY NEED TO BE ADD AS CHILD
        /// this fonction can be use to fetch all attendance or one attendance (implicitly)
        /// - Parameters:
        ///   - courseKey: pass the course key
        ///   - studentUID: pass the student UID
        /// - Returns: return the reference path
        static func attendanceRef (withCourseKey courseKey:String!, studentUID: String!)->DatabaseReference{
            
           return Database.database().reference().child(Constants.attendance).child(Constants.course).child(courseKey).child(Constants.student).child(studentUID).child(Constants.AttendanceKey)
        }
    }
    
    static var generateKey: String{
        
        let ref = Database.database().reference().childByAutoId()
        let gen = ref.key
        
        return gen
    }

}













