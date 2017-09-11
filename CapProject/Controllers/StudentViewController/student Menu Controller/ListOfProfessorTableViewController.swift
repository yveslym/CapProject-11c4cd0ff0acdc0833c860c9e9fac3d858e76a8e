//
//  ListOfProfessorTableViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/25/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class ListOfProfessorTableViewController: UITableViewController {

    @IBAction func backButton(_ sender: Any) {
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func configureTableView(){
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Student.current.course.count
    }

        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherListCell", for: indexPath) as! StudentListOfTeacherTableViewCell
        
        let course = Student.current.course[indexPath.row]
        cell.courseName.text = course.courseName
        cell.Section.text = course.section
        
        StudentServices.retrieveTeacherName(Withuid: course.teacherID, completion: {(name) in
          
            if name != nil{
                cell.TeacheName.text = name
            }
        })
        

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CourseServices.fetchStudentCourses(studentUID: NetworkConstant.currentUserUID!, completion: {(courseList) in
          
            Student.current.course = courseList
        })
            }

    
}
