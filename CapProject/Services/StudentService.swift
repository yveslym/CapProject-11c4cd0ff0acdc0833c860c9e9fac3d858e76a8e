//
//  StudentService.swift
//  CapProject
//
//  Created by Yves Songolo on 7/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//
//Student

import Foundation
import FirebaseDatabase
import FirebaseAuth.FIRAuthErrors
import Firebase
import UIKit
import SwiftQRCode
import AVFoundation



enum FIRAuthErrorCode: Int{
    case invalidEmail = 17008
    case wrongPassword = 17009
    case userNotFound = 17011
    case weakPassword = 17026
    case emailAlreadyInUse = 17007
}

class StudentServices{
    
    
    
    static func createNewStudent(withEmail email:String!, password: String!, completion: @escaping (Student?) -> Void) {
        
        guard let email   = email, let password = password
            else {return}
        
        let student = Student()
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(Authstudent,error) in
            
            if let error = error {
                
                if let errorCode = FIRAuthErrorCode(rawValue: (error._code)){
                    switch errorCode{
                    case .emailAlreadyInUse: print("email use/ wait for UIAlert")
                    case .weakPassword: print("weak password")
                    case .invalidEmail: print("invalid email")
                    default: assertionFailure(error.localizedDescription)
                    }
                    return completion(nil)
                }
                
            }
                
            else{
                
                student.email = email
                student.password = password
                
                let StudentAtribute = [Constants.firstName: student.firstName, Constants.lastName: student.lastName, Constants.email: student.email,Constants.username:student.username, Constants.uid: Authstudent?.uid]
                
                NetworkConstant.Student.studentInfoRef.setValue(StudentAtribute)
                 Student.setCurrent(student)
                Student.current.uid = Authstudent?.uid
                
               
               return completion(student)
                
            }
        })//end of sign up
        
        
    }
    
    //Function to retrieve student info from the firebase
    
    static func RetrieveStudentInfo(ForUID uid: String, completion: @escaping (Student?)->Void){
        
        
        let ref = Database.database().reference().child(Constants.student).child(NetworkConstant.currentUserUID!).child(Constants.info)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let student = Student(snapshot: snapshot) else{
                print(snapshot.value!)
                print ("retreiving not success")
                return completion(nil)
            }
            
            Student.setCurrent(student: student)
            
            return completion(student)
            
        })
    }
    
    static func SignInStudent(email: String!, password: String!, completion: @escaping (Student?)->Void){
        
        //        guard let Email = email, let Password = password
        //            else {return}
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authStudent,error) in
            
            if let error = error{
                
                if let errorCode = FIRAuthErrorCode(rawValue: (error._code)){
                    
                    switch errorCode{
                    case .invalidEmail: print("invalid email")
                    case .userNotFound: print("not user with this email and password")
                    default: print(error.localizedDescription)
                    }
                }
            }
                
                
            else{
                StudentServices.RetrieveStudentInfo(ForUID: (authStudent?.uid)!, completion: {(student)in
                    if let student = student{
                        Student.setCurrent(student, writeToUserDefault: true)
                        completion(student)
                    }
                    else{
                        print("couldn't retrieve student from firebase")
                    }
                    
                })
            }
        })
    }
    
    static func logOutStudent()->Bool{
        
        ///////////////////////////////////////
        //                                  //
        // logout logic need to be add here//
        //                                //
        ////////////////////////////////////
        
        return true
    }
    
    
    static func ScanAttendance (withAttendanceKey Key: String!, completion:@escaping (Course?)->Void){
        
        
        
        let courseIDScanned :String?
        let AttendanceScanned : String?
        var index = 0
        
        let keyArray = Key.components(separatedBy: " ")
        courseIDScanned = keyArray[0] // retrieve the course key from scan code
        AttendanceScanned = keyArray[1] // retrieve attendance key from scan code
        
        
        for mycourse in Student.current.course{
            if mycourse.courseID == courseIDScanned {
                
                StudentServices.StoreNewAttendanceObject(withKey: AttendanceScanned, CourseIndex: index, completion: {(atts) in
                    
                    if atts != nil {
                        Student.current.course[index].attendance.append(atts!)
                        
                        completion(Student.current.course[index])
                    }
                })
            }
            index = index+1
        }
    }
    
    /// function to retrieve teacher first and last name from database
    /// using teacher uid
    /// - Parameters:
    ///   - teacherUid: teacherUID is get from teacherUID store in the specific course
    ///   - completion: completion return the first and last name (cocaquinated)
    
    static func retrieveTeacherName(Withuid teacherUid: String!, completion:@escaping(String?)->Void){
        
        //let ref = Database.database().reference().child(Constants.teachers).child(Constants.info).child(teacherUid)
     
        TeacherServices.retrieveTeacherInfo(WithUID: teacherUid, completion: { teacher in
          
            if teacher != nil{
                return completion (teacher?.firstName)
            }
        })
        
        
//        print(teacherUid)
//        ref.observeSingleEvent(of: .value, with: {(snapshot) in
//            
//             guard let dict = snapshot.value as? [String: Any]
//                else{return completion(nil)}
//                
//                let firstName = dict[Constants.firstName] as! String
//                let lastname = dict[Constants.lastName] as! String
//                
//                let teachername = "\(firstName) \(lastname)"
//                print(teachername)
//                completion(teachername)
//            
//        })
    }
    
    
    
    
    /// function to add attendance get from teacher in the database
    ///
    /// - Parameter AttendanceKey: AttendanceKey is taking by scanning teacher bar code and use to create new attendance
    private static func StoreAttendanceKey( AttendanceKey: String!, courseIndex: Int!){
        
        let course = Student.current.course[courseIndex]
        let ref = Database.database().reference().child(Constants.course).child(course.courseID!).child(Constants.listOfAttendanceKey)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            let count = snapshot.childrenCount
            
            ref.updateChildValues(["Attendance \(count+1)":AttendanceKey])
            print ("key added")
        })
    }
    
    
    
    
    /// function to fetch the list of attendance in the database
    ///
    /// - Parameter completion: return true if the operation success
    static func FetchListAttendanceKey(withCourseIndex index: Int, completion: @escaping (Bool?)->Void){
        
        Student.current.course[index].listOfAttendance = []
        let course = Student.current.course[index]
        let ref = Database.database().reference().child(Constants.course).child(course.courseID!).child(Constants.listOfAttendanceKey)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            let count = Int(snapshot.childrenCount)
            
            print ("they are \(count) Attendance register")
            var index = 0
            
            while index < count {
                
                index = index+1
                let dict = snapshot.value as! [String:Any]
                let Attendance = dict["Attendance \(index)"] as? String
                Student.current.course[index].listOfAttendance.append(Attendance!)
                
                print("new AttendanceKey \(Attendance!) added")
            }
            completion(true)
        })
    }
    
    
    
    /// Function to fetch a single attendance object attendance from database using attendanceKey either from
    /// scanned attendance or attendanceKey from database
    /// - Parameters:
    ///   - AttendanceKey: pass the attendanceKey either from QRCode scanned or one fetched from database
    ///   - completion: return the attendance object fetched
    static func FetchAttendanceObject(withAttendanceKey AttendanceKey: String!, completion: @escaping (Attendance?)->Void){
        
        let ref = Database.database().reference().child(Constants.student).child(NetworkConstant.currentUserUID!).child(Constants.attendance).child(AttendanceKey)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if snapshot.hasChildren(){
                let Atts = Attendance(snapshot: snapshot)
                completion(Atts)
            }
            else{
                print("attendance key incorrect")
            }
        })
    }
    
    
    /// function to create and store new attendance with attendanceKey initially created by teacher
    /// and fetched with qrcode. the new attendance is return if operation success
    /// - Parameters:
    ///   - AttendanceKey: attendanceKey get from teacher qrcode
    ///   - completion: return the new Attendance
    static func StoreNewAttendanceObject(withKey AttendanceKey: String!, CourseIndex: Int!, completion:@escaping(Attendance?)->Void){
        
        let newAtt = Attendance()
        let ref = Database.database().reference().child(Constants.student).child(NetworkConstant.currentUserUID!).child(Constants.attendance).child(AttendanceKey)
        /*
         
         // do the attendance operation such as: present, absent or late compare to the time of arrival
         
         */
        newAtt.marckPresent()
        
        let attr : [String:Any] = [Constants.AttendanceKey:AttendanceKey, Constants.present: Constants.True, Constants.absent: Constants.False, Constants.late: Constants.False]
        ref.updateChildValues(attr)
        completion(newAtt)
    }
    
    /// function to retrieve all attendance object of a specific course using attendancekeyList
    ///fetced
    /// - Parameter index: index of specific course
    static func fetchAttendanceObjectList(withCourseIndex index: Int, completion: @escaping(Bool?)->Void){
        
        let course = Student.current.course[index]
        course.attendance = []
        
        
        let dispachegroup = DispatchGroup()
        StudentServices.FetchListAttendanceKey(withCourseIndex: index, completion: {(fetched) in
            
            if fetched!{
                
                if course.listOfAttendance.count > 0{
                    dispachegroup.enter()
                    for key in course.listOfAttendance{
                        
                        StudentServices.FetchAttendanceObject(withAttendanceKey: key, completion: {(atts) in
                            if atts != nil{
                                Student.current.course[index].attendance.append(atts!)
                            }
                        })
                    }
                    dispachegroup.leave()
                    
                    dispachegroup.notify(queue: .main, execute: {
                        print("Succesfully obtained courses from database.")
                        completion(true)
                        
                    })
                }
            }
        })
    }
}


































