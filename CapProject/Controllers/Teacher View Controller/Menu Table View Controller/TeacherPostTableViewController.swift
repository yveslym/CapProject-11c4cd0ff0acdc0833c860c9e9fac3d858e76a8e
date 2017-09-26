//
//  TeacherPostTableViewController.swift
//  CapProject
//
//  Created by Yveslym on 9/25/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

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
       
        do {
            
            Helpers.selectCourse(userID: NetworkConstant.currentUserUID!, completion: {(selectedCourse, index,course) in
            
            guard let selected = selectedCourse else {return}
            self.selectedCourseButton.titleLabel?.text = selected
            
            guard let course = course else {return}
                self.post.teacherLastName = course.teacher?.lastName
        })
    }
    }
    @IBAction func selectPost(_ sender: Any) {
        
        let post = [Constants.postNews,Constants.AssigmentPost, Constants.resources]
        
        Helpers.elementSelection(elementArray: post, completion: {selectedpost in
            guard selectedpost != nil else {return}
          self.post.postType = selectedpost
            self.selectedPostTypeButton.isHidden = false
            self.selectedPostButton.titleLabel?.text = selectedpost
            
        })
    }
    
    @IBAction func selectType(_ sender: Any) {
        
        switch self.post.postType {
        case Constants.postNews?:
            let newsTypes = [newsTtype.classCancle, newsTtype.classUpdate, newsTtype.examUpdate, newsTtype.midtermUpdate, newsTtype.roomChange,newsTtype.other]
            Helpers.elementSelection( elementArray: newsTypes, completion: {selectedpost in
                guard let selected = selectedpost else {return}
                self.post.subType = selected
                      self.selectedPostTypeButton.titleLabel?.text = selected
            })
        case Constants.AssigmentPost?:
            let assignmentPost = [AssignmentType.exam, AssignmentType.exercies, AssignmentType.homework, AssignmentType.quiz]
            Helpers.elementSelection(elementArray: assignmentPost, completion:{ selected in
                guard let selected = selected else {return}
                self.post.subType = selected
                      self.selectedPostTypeButton.titleLabel?.text = selected
            })
        case Constants.resources?:
            let resources = [RessourceType.attachement,RessourceType.wikiLink, RessourceType.youtubeLink, RessourceType.otherLink]
            Helpers.elementSelection(elementArray: resources, completion:{ selected in
                guard let selected = selected else {return}
                self.post.subType = selected
                      self.selectedPostTypeButton.titleLabel?.text = selected
            })
        default:
            self.post.subType = nil
        }
    
  
    }
    
   
}
