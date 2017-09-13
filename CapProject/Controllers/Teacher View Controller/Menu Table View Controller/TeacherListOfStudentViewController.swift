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

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var selectCourse: UITextField!
    var index = Int()
    var courseName = [String]()
    var course = [Course]()
    var attendance = [Attendance]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.delegate = self
        self.listTableView.dataSource = self as? UITableViewDataSource

        // Do any additional setup after loading the view.
    }
    
    func pickCourse(){
        
        CourseServices.fetchTeacherCourses(teacherUID: Teacher.current.uid!, completion: {listOfCourse in
            self.course = []
          self.course = listOfCourse!
            
            
        })
    }
    
    @IBAction func SelectCourse(_ sender: Any){
        
        self.course = []
        self.courseName = []
        
        CourseServices.fetchTeacherCourses(teacherUID: NetworkConstant.currentUserUID!, completion: { listOfCourse in
            
            
            self.course = listOfCourse!
            
            for course in listOfCourse!{
                self.courseName.append(course.courseName!)
            }
            
            self.course = listOfCourse!
        
            ActionSheetStringPicker.show(withTitle: "Select Class", rows: self.courseName, initialSelection: 1, doneBlock: {
                
                picker, indexes, values in
                
                if indexes >= 0{
                    
                    self.selectCourse.text = values as? String
                    self.index = indexes
                    
                    return
                }
                    
                else {
                    print("index is less than 0, avoid out of bound // line 58")
                    
                }
            }, cancel: {ActionSheetStringPicker in return }, origin: sender)
            
        })

    }
    
    @IBAction func selectAttendance(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.course[self.index].student.count
    }
//    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
//        
//        
//        return UITableViewCell()
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentList", for: indexPath) as! TeacherListOfStudentTableViewCell
        
                let mystudent = self.course[self.index].student
        
                cell.firstName.text = mystudent[indexPath.row].firstName
                cell.lastName.text =  mystudent[indexPath.row].lastName
        
        return cell
    }

}























