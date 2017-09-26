//
//  Helpers.swift
//  CapProject
//
//  Created by Yves Songolo on 8/3/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0


extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}


class Helpers{
    
    //function to check if the domain of email is edu
    static func checkEmailEdu(forEmail email: String)-> Bool{
        var correct: Bool = false
        
        if email.hasSuffix("@gmail.com"){
            correct = true
            return correct
        }
        return correct
    }
    
    static var teacherSelected = false
    
    static var studentSelected = false
    
    static var isScanned = false
    
    static var scannedCourse = Course()
    
    static var addStudent = false
    
    static var createAttendance = false
    
   static func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
        return today_string
    }
    
    static func selectCourse(userID: String, completion: @escaping (String?,Int?, Course?)-> Void) {
        
        var courseName = [String]()
        var listofcourse = [Course]()
        var index : Int?
        var selectedCourse : String?
        CourseServices.fetchTeacherCourses(teacherUID: userID, completion: { listOfCourse in
            guard let list = listOfCourse else {return}
            listofcourse = list
            
            for course in listOfCourse!{
                
                courseName.append(course.courseName!)
                print(courseName)
            }
            
           
            ActionSheetStringPicker.show(withTitle: "Select Class", rows: courseName, initialSelection: 1, doneBlock: {
                
                picker, indexes, values in
                
                if indexes >= 0{
                    
                    selectedCourse = values as? String
                    index = indexes
                    
                    return
                }
                else {
                    print("index is less than 0, avoid out of bound // line 58")
                    
                }
            }, cancel: {ActionSheetStringPicker in return }, origin: self)
            
        })
        if index != nil{
     completion(selectedCourse,index,listofcourse[index!])
        }
        else{
            completion(selectedCourse, nil, nil)
        }
    }
    
    static func elementSelection (elementArray: [String], completion: @escaping (String?)-> Void){
     
        var selectedElement : String?
        
        ActionSheetStringPicker.show(withTitle: "Select Post", rows: elementArray, initialSelection: 1, doneBlock: {
            
            picker, indexes, values in
            
            if indexes >= 0{
                
                selectedElement = values as? String
                return
            }
            else {
                print("index is less than 0, avoid out of bound // line 58")
                
            }
        }, cancel: {ActionSheetStringPicker in return }, origin: self)
        
        completion(selectedElement)
        
    }
}


















