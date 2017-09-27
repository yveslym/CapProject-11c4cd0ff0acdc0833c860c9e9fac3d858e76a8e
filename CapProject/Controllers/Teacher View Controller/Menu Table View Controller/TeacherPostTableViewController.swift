//
//  TeacherPostTableViewController.swift
//  CapProject
//
//  Created by Yveslym on 9/25/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class TeacherPostTableViewController: UITableViewController {
    let post = Post()
    
    enum selectionError: Error {
        case classNotSelected
        case noIndexPassed
    }
    
    @IBOutlet weak var selectedPostButton: UIButton!
    @IBOutlet weak var selectedCourseButton: UIButton!
    @IBOutlet weak var selectedPostTypeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectCourse(_ sender: Any) {
       
        CourseServices.fetchTeacherCourses(teacherUID: NetworkConstant.currentUserUID!,
           completion: {courses in
            guard let list = courses else {return}
           var coursename = [String]()
            for course in courses!{
                coursename.append(course.courseName!)
            }
            ActionSheetStringPicker.show(withTitle: "Select Course", rows: coursename, initialSelection: 1, doneBlock: {
                
                picker, indexes, values in
                
                if indexes >= 0{
                    
                    self.post.courseID = list[indexes].courseID
                    self.selectedPostButton.titleLabel?.text = values as? String
                    return
                }
                else {
                    print("index is less than 0, avoid out of bound // line 58")
                    
                }
            }, cancel: {ActionSheetStringPicker in return }, origin: sender)
            
        })
            
   
    
    }
    @IBAction func selectPost(_ sender: Any) {
        
        let post = [Constants.postNews,Constants.AssigmentPost, Constants.resources]
        
        ActionSheetStringPicker.show(withTitle: "Select Post", rows: post, initialSelection: 1, doneBlock: {
            
            picker, indexes, values in
            
            if indexes >= 0{
                
                self.post.postType = values as? String
                self.selectedPostButton.titleLabel?.text = values as? String
                return
            }
            else {
                print("index is less than 0, avoid out of bound // line 58")
                
            }
        }, cancel: {ActionSheetStringPicker in return }, origin: sender)
    }
    
    @IBAction func selectType(_ sender: Any) {
        
        switch self.post.postType {
        case Constants.postNews?:
            let newsTypes = [newsTtype.classCancle, newsTtype.classUpdate, newsTtype.examUpdate, newsTtype.midtermUpdate, newsTtype.roomChange,newsTtype.other]
            ActionSheetStringPicker.show(withTitle: "Select Subject", rows: newsTypes, initialSelection: 1, doneBlock: {
                
                picker, indexes, values in
                
                if indexes >= 0{
                    
                    self.post.subType = values as? String
                    self.selectedPostTypeButton.titleLabel?.text = values as? String
                    return
                }
                else {
                    print("index is less than 0, avoid out of bound // line 58")
                    
                }
            }, cancel: {ActionSheetStringPicker in return }, origin: sender)
        case Constants.AssigmentPost?:
            let assignmentPost = [AssignmentType.exam, AssignmentType.exercies, AssignmentType.homework, AssignmentType.quiz]
            ActionSheetStringPicker.show(withTitle: "Select Subject", rows: assignmentPost, initialSelection: 1, doneBlock: {
                
                picker, indexes, values in
                
                if indexes >= 0{
                    
                    self.post.subType = values as? String
                    self.selectedPostTypeButton.titleLabel?.text = values as? String
                    return
                }
                else {
                    print("index is less than 0, avoid out of bound // line 58")
                    
                }
            }, cancel: {ActionSheetStringPicker in return }, origin: sender)
        case Constants.resources?:
            let resources = [RessourceType.attachement,RessourceType.wikiLink, RessourceType.youtubeLink, RessourceType.otherLink]
            ActionSheetStringPicker.show(withTitle: "Select Subject", rows: resources, initialSelection: 1, doneBlock: {
                
                picker, indexes, values in
                
                if indexes >= 0{
                    
                    self.post.subType = values as? String
                    self.selectedPostTypeButton.titleLabel?.text = values as? String
                    return
                }
                else {
                    print("index is less than 0, avoid out of bound // line 58")
                    
                }
            }, cancel: {ActionSheetStringPicker in return }, origin: sender)
        default:
            self.post.subType = nil
        }
    
  
    }
    
   
}
