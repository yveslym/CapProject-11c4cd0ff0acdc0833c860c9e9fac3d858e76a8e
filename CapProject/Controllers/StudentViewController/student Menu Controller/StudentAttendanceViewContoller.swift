//
//  StudentAttendanceViewContoller.swift
//  CapProject
//
//  Created by Yves Songolo on 8/10/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import SwiftQRCode

class StudentAttendanceViewContoller: UIViewController {
    
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    let scanner = QRCode()
    
    
    /// function to setup the view before appear
    func configureVC(){
        self.course.isHidden = false
        self.section.isHidden = false
        self.teacher.isHidden = false
        self.markImage.isHidden = false
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            
            var value = String(stringValue)!
            if value != ""{
                let keyArray = value.components(separatedBy: " ")
                let courseIDScanned = keyArray[0] // retrieve the course key from scan code
                let AttendanceScanned = keyArray[1] // retrieve attendance key from scan code
                AttendanceServices.MarkPresent(courseKey: courseIDScanned, attendanceKey: AttendanceScanned)
                
                CourseServices.fetchSingleCourse(courseKey: courseIDScanned, completion: {course in
                  
                    if course != nil{
                        self.course.text = course?.courseName
                        self.section.text = course?.section
                        self.teacher.text = course?.teacher?.lastName
                        self.configureVC()
                    }
                })
            }
            value = ""
        }
        scanner.scanFrame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scanner.startScan()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureVC()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    
    
    
}
