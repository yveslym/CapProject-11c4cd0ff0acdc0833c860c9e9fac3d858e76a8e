//
//  StudentAddNewCourseViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import SwiftQRCode

class StudentAddNewCourseViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var section: UILabel!
    
    @IBOutlet weak var schedule: UILabel!
    
    @IBOutlet weak var firstday: UILabel!
    
    @IBOutlet weak var lastDay: UILabel!
    
    @IBOutlet weak var teacherName: UILabel!
    
    let scanner = QRCode()
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func cancelCourse(_ sender: Any) {
        if  Student.current.course.count-1 > 0{
            Student.current.course.remove(at: Student.current.course.count-1)
        }
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            
            let keys = String(stringValue)
            if !(keys?.isEmpty)!{
                
                print(keys!)
                let keyArray = keys?.components(separatedBy: " ")
                _ = keyArray?[0]
                let courseKey = keyArray?[1]
                
                CourseServices.fetchSingleCourse(courseKey: courseKey, completion: {course in
                    
                    if course != nil{
                        CourseServices.StoreCourse(course: course!)
                        self.name.text = course?.courseName
                        self.section.text = course?.section
                        self.teacherName.text = course?.teacher?.lastName
                        //print("course id:\(course?.courseID!) line 80")
                        self.configureVC()
                    }
                    
                })
                
            }
        }
        
    }
    
    func configureVC(){
        
        self.name.isHidden = false
        self.section.isHidden = false
        self.teacherName.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scanner.startScan()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
