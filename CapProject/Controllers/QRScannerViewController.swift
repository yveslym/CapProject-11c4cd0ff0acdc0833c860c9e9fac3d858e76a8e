//
//  QRScannerViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/17/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import SwiftQRCode

class QRScannerViewController: UIViewController {
    
    @IBOutlet weak var complete: UIButton!
    var teacherID:String!
    var courseKey: String!
    var keys: String?
    let scanner = QRCode()
    var isCourseExist = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scanCode()
    }
    
    func scanCode(){
        
        scanner.prepareScan(view) { (stringValue) -> () in
            
            print (stringValue)
            if stringValue != ""{
                
                Helpers.isScanned = true
                self.keys = stringValue
                let keyArray = self.keys?.components(separatedBy: " ")
                self.teacherID = keyArray?[0] // retrieve the course key from scan code
                self.courseKey = keyArray?[1] // retrieve attendance key from scan code
                
                CourseServices.fetchSingleCourse(typeOfUser: Constants.teachers, UserUID: self.teacherID, courseKey: self.courseKey, completion: {(course) in
                  
                    if course != nil{
                        CourseServices.StoreCourse(course: course)
                        print ("new course added: \(course.courseName!)")
                    }
                    else { print("couldn't retrieve course")}
                })
                
            }
                else{
                    print("course exist already")
                }
            }
        
        scanner.scanFrame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // start scan
        scanner.startScan()
        
    }
}
