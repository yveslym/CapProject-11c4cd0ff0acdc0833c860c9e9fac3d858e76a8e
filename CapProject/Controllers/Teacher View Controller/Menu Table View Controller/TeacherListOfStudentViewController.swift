//
//  TeacherListOfStudentViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 9/12/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class TeacherListOfStudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectCourse: UITextField!
    var index : Int?
    var courseName = [String]()
    var course = [Course]()
    var attendance = [Attendance]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
         self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchCourse()
    }
    
    func fetchCourse(){
        CourseServices.fetchTeacherCourses(teacherUID: NetworkConstant.currentUserUID!, completion: {listOfCourse in
            self.course = []
            self.courseName = []
            for course in listOfCourse!{
                self.courseName.append(course.courseName!)
            }
            self.course = listOfCourse!
        })
    }
    
    @IBAction func doneButton(_ sender: Any){
    
        let initialVC = UIStoryboard.initialViewController(for: .Teachermain)
        
        self.view.window?.rootViewController = initialVC
        //self.dismiss(animated: true, completion: nil)
        
        self.viewDidDisappear(true)
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func SelectCourse(_ sender: Any){
        
        if self.course.count != 0 {
        ActionSheetStringPicker.show(withTitle: "Select Class", rows: self.courseName, initialSelection: 1, doneBlock: {
            
            picker, indexes, values in
            
            
            guard let values = values else {return}
            
                self.selectCourse.text = values as? String
                self.selectCourse.isEnabled = false
                self.index = indexes
            
        }, cancel: {ActionSheetStringPicker in return }, origin: sender)
            
    }
        else
        {
            let alertController = UIAlertController()
            alertController.title = " Message!!!"
            alertController.message = " There's no course register, please register course first"
            self.present(alertController, animated: true, completion: nil)
            
            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
        }
    }
    @IBAction func selectAttendance(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let count = self.index else{return 0}
        
        return self.course[count].student.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentList", for: indexPath) as! TeacherListOfStudentTableViewCell
        let student = self.course[self.index!].student[indexPath.row]
        
        cell.firstName.text = student.firstName ?? ""
        cell.lastName.text = student.lastName ?? ""
        cell.studentLevel.text = student.level ?? ""
        
     return cell
    }
}























