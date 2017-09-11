//
//  Course.swift
//  CapProject
//
//  Created by Yves Songolo on 8/8/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import Firebase

class Course: NSObject{
    
    var courseName : String?
    var section : String?
    var courseID: String?
    var Description: String?
    var teacher: Teacher?
    var teacherID = String()
    var student = [Student]()
    var listOfAttendance = [String]()
    var todayAttendance : String?
    var attendance = [Attendance]()
    var schedule : Schedule?
    var courseAdress : String?
    
    // add course start time and end time
    
    override init (){
        self.courseName = ""
        self.courseID   = ""
        self.Description = ""
        self.section = ""
       
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let dict = snapshot.value as? [String: Any]
            
            else{return nil}
        
        if snapshot.hasChildren() == true{
           print (" snapshot as data")
        }
        else{
            print("snapshot doesnt have data")
        }
       
        self.courseID = dict[Constants.courseID] as? String
        self.courseName = dict["name"] as? String
        self.Description = ""//dict[Constants.description] as? String
       // self.todayAttendance =
        self.teacherID = (dict[Constants.teachers] as? String)!
        self.section = dict[Constants.section] as? String
    }
    
    func getStudent(withUID studentUID: String) -> Student{
        
        var studentFind = Student()
        for indexStudent in self.student{
            if indexStudent.uid == studentUID{
                studentFind = indexStudent
            }
        }
    return studentFind
    }
}













