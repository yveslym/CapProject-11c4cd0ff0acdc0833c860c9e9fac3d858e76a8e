//
//  AttendanceServices.swift
//  CapProject
//
//  Created by Yves Songolo on 8/14/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuth.FIRUser
import Firebase


class AttendanceServices: NSObject{
    
    
    /// function to punch in student (mark present when student is on time)
    ///
    /// - Parameters:
    ///   - courseKey: pass the course key get from the qr code when scanned
    ///   - attendanceKey: get the attendance key geot from the qr code when scanned
    ///   - completion: return the new attendance
    static func MarkPresent( courseKey: String!, attendanceKey: String!){
        
        let ref = NetworkConstant.attencace.attendanceRef(withCourseKey: courseKey, studentUID: NetworkConstant.currentUserUID!).child(attendanceKey)
        
        
        /*
         need to add time operations, such what register the real time the student punch in
         */
        
        let atts = [Constants.present:Constants.True, Constants.absent: Constants.False, Constants.late : Constants.False, Constants.AttendanceKey: attendanceKey]
        
        ref.setValue(atts)
        
        let attendance = Attendance()
        attendance.present = true
        attendance.late = false
        attendance.absent = false
        attendance.AttendanceID = attendanceKey
        AttendanceServices.storeAttandance(coursekey: courseKey, attendance: attendance)
    }
    
    /// function to mark student absent
    ///
    /// - Parameters:
    ///   - courseKey: pass the course key get from the qr code when scanned
    ///   - attendanceKey: get the attendance key geot from the qr code when scanned
    ///   - completion: return the new attendance
    static func MarkLate ( courseKey: String!, attendanceKey: String!){
        
        let ref = NetworkConstant.attencace.attendanceRef(withCourseKey: courseKey, studentUID: NetworkConstant.currentUserUID!).child(attendanceKey)

        /*
         need to add time operations, such what register the real time the student punch in
         */
        let atts = [Constants.present:Constants.False, Constants.absent: Constants.False, Constants.late : Constants.True, Constants.AttendanceKey: attendanceKey]
        
        ref.setValue(atts)
        
        let attendance = Attendance()
        attendance.present = false
        attendance.late = true
        attendance.absent = false
        
        AttendanceServices.storeAttandance(coursekey: courseKey, attendance: attendance)
    }
    
    
    /// function to mark student absent
    ///
    /// - Parameters:
    ///   - courseKey: pass the course key get from the qr code when scanned
    ///   - attendanceKey: get the attendance key geot from the qr code when scanned
    ///   - completion: return the new attendance
    static func MarkAbsent ( courseKey: String!, attendanceKey: String!){
        
        let ref = NetworkConstant.attencace.attendanceRef(withCourseKey: courseKey, studentUID: NetworkConstant.currentUserUID!).child(attendanceKey)
        
        /*
         need to add time operations, such what register the real time the student punch in
         */
        let atts = [Constants.present:Constants.False, Constants.absent: Constants.True, Constants.late : Constants.False, Constants.AttendanceKey: attendanceKey]
        
        ref.setValue(atts)
        
        let attendance = Attendance()
        attendance.present = false
        attendance.late = false
        attendance.absent = true
    AttendanceServices.storeAttandance(coursekey: courseKey, attendance: attendance)
    }
    
    /// function to fetch all attendance stored under an specific student,
    ///and specific course
    /// - Parameters:
    ///   - course: pass the course
    static func fetchAttendances(course: Course!, completion: @escaping ([Attendance]?)-> Void){
        
        let ref = NetworkConstant.attencace.attendanceRef(withCourseKey: course.courseID, studentUID: NetworkConstant.currentUserUID!)
        
        ref.observeSingleEvent(of: .value, with: {snapshot in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return completion([])}
            let attendance = snapshot.reversed().flatMap(Attendance.init)
            return completion(attendance)
            
        })
    }
    
    
    /// function to store attendance in the database
    /// it's a function use to store student attendance in the firebase
    /// - Parameters:
    ///   - coursekey: pass the course key
    ///   - attendance: pass the attandance info
    static func storeAttandance(coursekey: String!, attendance: Attendance!){
        
//        let ref = Database.database().reference().child(Constants.attendance).child(NetworkConstant.currentUserUID!).child(coursekey).child(attendance.AttendanceID)
        
        let ref = NetworkConstant.attencace.attendanceRef(withCourseKey: coursekey, studentUID: NetworkConstant.currentUserUID!).child(attendance.AttendanceID)

        
        let atts = [Constants.present: String(attendance.present), Constants.absent:String(attendance.absent), Constants.late: String(attendance.late), Constants.AttendanceKey:attendance.AttendanceID]
        
        ref.setValue(atts)
    }
}









