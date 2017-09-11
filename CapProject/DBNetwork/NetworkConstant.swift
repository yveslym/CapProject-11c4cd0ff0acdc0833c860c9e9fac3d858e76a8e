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
        
    
    
   // static func AddTeacherinDatabase(withTeacher teacher: Teacher){
        
//        let Attrs = [Constants.firstName: teacher.firstName,Constants.lastName: teacher.lastName, Constants.email: teacher.email, Constants.uid:NetworkConstant.currentUserUID]
//        NetworkConstant.teacherInfoRef.setValue(Attrs)
//    }
    
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
        //returnning an existing attendance path
        static func attendanceRef (withCourseKey key:String, AttendanceKey: String)->DatabaseReference{
            
            return NetworkConstant.course.attendenceRef.child(key).child(Constants.attendance).child(AttendanceKey)
        }
        
        static func newAttendance (withCourseKey courseKey:String)->DatabaseReference?{
            let ref = NetworkConstant.course.attendenceRef.child(courseKey)
            if !(ref.key.isEmpty){
                ref.child(Constants.attendance).childByAutoId()
                print ("new atendance added")
            }
            return ref
        }
    }
}

