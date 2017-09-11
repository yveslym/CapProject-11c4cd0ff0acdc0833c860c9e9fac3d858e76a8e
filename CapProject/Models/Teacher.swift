//
//  Teacher.swift
//  CapProject
//
//  Created by Yves Songolo on 7/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import Firebase
import SwiftQRCode


class Teacher: NSObject{
    
    var username: String?
    var firstName: String?
    var lastName: String?
    var email : String?
    var password:String?
    var phoneNumber : Int?
    var uid : String?
    let type = "teacher"
    var course = [Course]()
    var listOfCourseKey = [String]()
    var listOfStudentUID = [String]()
    var courseCount = Int()
    //var profilImage = UIImage()
    
    
    private static var _current : Teacher?
    
    static var current : Teacher{
        guard let teacher = _current else { fatalError("Teacher doesn't exist")}
        return teacher
    }
    
    override init(){
        self.username = ""
        self.lastName = ""
        self.password = ""
        self.email = ""
        self.firstName = ""
        self.phoneNumber = 0
        self.uid = ""
       // self.profilImage = UIImage()
    }
    
    init(firstname: String, lastname: String,Username:String,email:String, phone:Int){
        self.firstName = firstname
        self.lastName = lastname
        self.email = email
        self.username = Username
        self.password = ""
        self.phoneNumber = 0
        self.uid = ""
        //self.profilImage = UIImage()
        
    }
    
    init (withEmail email: String!){
        self.username = ""
        self.lastName = ""
        self.password = ""
        self.email = email
        self.firstName = ""
        self.phoneNumber = 0
        self.uid = ""
       // self.profilImage = UIImage()
  
    }
    
    init? (snapshot: DataSnapshot){
        guard let dict = snapshot.value as? [String:Any]
            
            else{
                print ("couldn't snapshot")
                
                return nil
        }
        
        self.firstName = dict[Constants.firstName] as? String
        self.lastName = dict[Constants.lastName] as? String
        self.email = dict[Constants.email] as? String
        self.phoneNumber = dict[Constants.phoneNumber] as? Int
        self.uid = dict[Constants.uid] as? String
        self.password = ""
        self.username = dict[Constants.username] as? String
       // self.profilImage = (teacher?.profilImage)!
        
    }
    
    class func setCurrent(teacher: Teacher, WritetoTeacherDefault: Bool = false){
        
        if WritetoTeacherDefault == true{
            
            let userType = UsersType()
            
            userType.saveTeacher(withTeacher: teacher, archiveThisTeacher: true)
            
           // let data = NSKeyedArchiver.archivedData(withRootObject: userType) as AnyObject
            
           // UserDefaults.standard.set(userType, forKey: Constants.current)
        }// end of archiving
        _current = teacher
    }// end of setCurrent
    
    static func setCurrent(teacher:Teacher){
        _current = teacher
    }
    
    func getUID (isTeacherAuth: Bool = false){
        
        if isTeacherAuth == true{
            self.uid = Auth.auth().currentUser?.uid
        }
    }
    //function to create course with course as parameter
    func createCourse(withCourse course: Course){
    
        self.course.append(course)
    
    
    
    }
    
    // function to generate qr code with SwiftQRCode framework
        
    func isTodayAttendanceExist(CourseIndex index:Int)->Bool{
        return (self.course[index].todayAttendance != nil) ?  true :  false
    }
}




























