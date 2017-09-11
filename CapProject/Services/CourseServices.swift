//
//  CourseServices.swift
//  CapProject
//
//  Created by Yves Songolo on 8/15/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CourseServices{
    
   
    /// function to create new course. the new course created is stored under teacher UID
    /// thus a single teacher can have multiple course stored. "this function is use by teacher"
    /// - Parameters:
    ///   - course: course get all the new course info that is need to be created
    ///   - completion: return a same course with a course key associate with this specific course
    static func create(withCoourse course: Course, completion: @escaping (Course?)->Void){
        
        let ref = Database.database().reference().child(Constants.course).child(NetworkConstant.currentUserUID!).childByAutoId()
        
        let teacherRef = Database.database().reference().child(Constants.teachers).child(NetworkConstant.currentUserUID!).child(Constants.courseInfo).child(ref.key)

        course.courseID = ref.key
        
        let atts = [Constants.name: course.courseName, Constants.section : course.section,Constants.courseID : course.courseID, Constants.description : course.Description, Constants.teachers: Teacher.current.uid]
        
        teacherRef.setValue(atts)
        ref.setValue(atts)
        
        return completion(course)

    }
    
    
    /// function to store course both under student path and course path.
    /// the student add the course on course list and the course add the student under student list
    /// - Parameter course: pass the course to store by student
    static func StoreCourse( course: Course!){
        
        let Studentref = Database.database().reference().child(Constants.student).child(NetworkConstant.currentUserUID!).child(Constants.courseInfo).child(course.courseID!)
        

        let atts = [Constants.name: course.courseName, Constants.section : course.section,Constants.courseID : course.courseID, Constants.description : course.Description, Constants.teachers: course.teacherID]
        
            Studentref.setValue(atts)
        
        
        StudentServices.RetrieveStudentInfo(ForUID: NetworkConstant.currentUserUID!, completion: {student in
          
            if student != nil{
                
                let atts = [Constants.firstName:student?.firstName,Constants.lastName: student?.lastName, Constants.email:student?.email, Constants.username:student?.username,Constants.level:student?.level, Constants.uid: student?.uid]
                
                 let courseRef = Database.database().reference().child("course").child(course.courseID!).child((student?.uid!)!)
                courseRef.setValue(atts)
            }
        })
    }
    
    /// function to fetch course information
    ///
    /// - Parameters:
    ///   - UserKey: pass the user key (either teacher UID or student UID)
    ///   - courseKey: pass the course ID of the single course we need to fetch
    ///   - completion: return the course fetched from firebase
    static func fetchSingleCourse (typeOfUser: String!, UserUID: String!, courseKey: String!, completion: @escaping(Course!)-> Void){
       
       // let ref = Database.database().reference().child("course").child(UserKey).child(courseKey)
        
        if (typeOfUser != Constants.teachers) && (typeOfUser != Constants.student){
            print("type of user incorect")
            return completion(nil)
        }
        
     let teacherRef = Database.database().reference().child(typeOfUser).child(UserUID).child(Constants.courseInfo).child(courseKey)
        
        teacherRef.observeSingleEvent(of: .value, with: {(snapshot) in
            
            let course = Course(snapshot: snapshot)
            if course != nil{
                print(course?.courseName)
                return completion(course)
            }
                
            else{
                return completion(nil)
            }
        })
    }
    
    
    /// function to fetch all list of student in a particular class
    ///
    /// - Parameters:
    ///   - courseKey: pass the coursekey
    ///   - completion: return the list of course the student is suscribe on it.
    static func fetchListofStudent(courseKey: String!, completion:@escaping ([Student])-> Void){
        
        let ref = Database.database().reference().child("course").child(courseKey)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return completion([])}
            
            let students = snapshot.reversed().flatMap(Student.init)
            
            return completion(students)
        })
    }
    
    /// function to fetch list of course of a particular student suscribed on it
    ///
    /// - Parameters:
    ///   - studentUID: pass the student uid
    ///   - completion: return the list of courses
    static func fetchStudentCourses(studentUID: String!,completion: @escaping ([Course])-> Void){
        
        let ref = Database.database().reference().child(Constants.student).child(studentUID).child(Constants.courseInfo)

        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return completion([])}
            
            let courses = snapshot.reversed().flatMap(Course.init)
            
            completion(courses)
            
        })
    }

    /// function to fetch the list of course  of a particular teacher
    ///
    /// - Parameters:
    ///   - teacherUID: pass the teacher uid
    ///   - completion: return list of courses
    static func fetchTeacherCourses(teacherUID: String!,completion: @escaping ([Course]?)-> Void){
        
        let ref = Database.database().reference().child(Constants.teachers).child(NetworkConstant.currentUserUID!).child(Constants.courseInfo)
        
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return completion([])}
            
        
            let courses = snapshot.reversed().flatMap(Course.init)
            print(courses)
            completion(courses)
            
        })
    }
}
































