//
//  Helpers.swift
//  CapProject
//
//  Created by Yves Songolo on 8/3/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation


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
}


