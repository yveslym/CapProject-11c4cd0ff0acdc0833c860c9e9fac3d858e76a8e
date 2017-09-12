//
//  TeacherServices.swift
//  CapProject
//
//  Created by Yves Songolo on 7/31/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase
import SwiftQRCode



class TeacherServices{
    
    /// function to create a new teacher and save in the firebase database
    ///
    /// - Parameters:
    ///   - email: pass the email of the new useer
    ///   - password: pass the password of the new user
    ///   - completion: return the new teacher with an UID
    static func createTeacher(withEmail email: String!, password: String!,completion:@escaping (Teacher?)->Void){
        
        guard let email = email, let password = password
            else {return}
        
        let teacher = Teacher(withEmail: email)
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(AuthTeacher,error) in
            
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
                
                let TeacherAtribute = [Constants.firstName: teacher.firstName, Constants.lastName: teacher.lastName, Constants.email: teacher.email,Constants.username:teacher.username, Constants.uid: AuthTeacher?.uid]
                
                NetworkConstant.teacherInfoRef.setValue(TeacherAtribute)
                Teacher.setCurrent(teacher: teacher)
                completion(teacher)
                
            }
        })//end of sign up
    }
    static func retrieveTeacherInfo(WithUID uid: String!,completion:@escaping (Teacher?)->Void){
        
        
        
        print("teacher uid: \(uid!) line 63")
        
        let ref = Database.database().reference().child(Constants.teachers).child(uid).child(Constants.info)
        
        //let ref =  NetworkConstant.teacherInfoRef
        
        ref.observeSingleEvent(of: .value, with:{(snapshot) in
            
            print (snapshot.children)
            
            guard let teacher = Teacher(snapshot: snapshot)
                else {
                    print ("retreiving not success")
                    return completion (nil)
            }
            
            print("teacher uid: \(teacher.firstName!) line 76")
            
            return completion(teacher)
            print("retrive successful")
        })
    }
    
    /// function to sign in and get the teacher from the firebase
    ///
    /// - Parameters:
    ///   - email: pass the teacher email
    ///   - password: pass the teacher password
    ///   - completion: return the teacher info get from the firebase
    static func SignIn(withEmail email: String!, password: String!, completion: @escaping(Teacher?)->Void){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authTeacher,error) in
            print("login teacher")
            
            //print(authTeacher?.email as! String)
            
            if let error = error{
                
                print("error occured")
                if let errorCode = FIRAuthErrorCode(rawValue: (error._code)){
                    
                    switch errorCode{
                    case .invalidEmail: print("invalid email")
                    case .userNotFound: print("not user with this email and password")
                    default: print(error.localizedDescription)
                    }
                }
            }
                
            else{
                print ("not error occured")
                TeacherServices.retrieveTeacherInfo(WithUID: (authTeacher?.uid)!, completion: {(teacher) in
                    if let teacher = teacher {
                        Teacher.setCurrent(teacher: teacher, WritetoTeacherDefault: true)
                        completion (teacher)
                    }
                    else{
                        print("could not retrieve info")
                    }
                    
                })
                
            }
            
        })
    }
    
    static func logout()->Bool{
        
        ////////////////////////////////////////
        //                                   //
        // logout logic need to be add here //
        //                                 //
        ////////////////////////////////////
        
        return true
        
    }
    
    /// function to generate QRCode using the index of the specific course
    /// the function pass 2 code, the teacher UID and the course Key which will be use to add student
    /// - Parameters:
    ///   - index: Index of the course in the list of course
    ///   - iconView: image view that will contain the generated image
    static func genrateQRCode(CourseIndex index:Int, iconView: UIImageView){
        
        CourseServices.fetchTeacherCourses(teacherUID: NetworkConstant.currentUserUID!, completion: { course in
            let courseID = course?[index].courseID
            iconView.image = QRCode.generateImage((NetworkConstant.currentUserUID!) + " " + (courseID)!, avatarImage: UIImage(named: "avatar"), avatarScale: 0.3)
            
        })
    }
    
    static func genrateAtteandaceQRCode(CourseIndex index:Int, iconView: UIImageView){
        
        
        CourseServices.fetchTeacherCourses(teacherUID: NetworkConstant.currentUserUID!, completion: { course in
            
            if course != nil{
                let courseID = course?[index].courseID
                
                AttendanceServices.createAttendanceKey(courseKey: courseID, completion: { attendanceCode in
                    
                    iconView.image = QRCode.generateImage("\(courseID!) \(attendanceCode)", avatarImage: UIImage(named: "avatar"), avatarScale: 0.3)
                    
                })
            }
            
        })
    }
    
}










