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
    var posts = [Post]()
    var schedule : Schedule?
    var courseAdress : String?
    var numberOfStudent: Int?
    
    // add course start time and end time
    
    override init (){
        self.courseName = ""
        self.courseID   = ""
        self.Description = ""
        self.section = ""
        self.student = []
       
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
        self.numberOfStudent = Int(snapshot.childrenCount)
        var studentList = [Student]()
        var teacherInfo = Teacher()
        var Posts = [Post]()
        //==> Mark retrieve teacher info and list of student in this course
        CourseServices.fetchListofStudent(courseKey: snapshot.key, completion: {students in
            if students != nil {studentList = students!}
        })
        
        TeacherServices.retrieveTeacherInfo(WithUID: self.teacherID, completion: {teacher in
            if teacher != nil { teacherInfo = teacher!}
        })
        
        PostService.fetchPosts(withCourseKey: self.courseID!, completion: {postList in
            guard let post = postList else {return}
            Posts = post
        })
        
         self.student = studentList
        self.teacher = teacherInfo
        self.posts = Posts
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













