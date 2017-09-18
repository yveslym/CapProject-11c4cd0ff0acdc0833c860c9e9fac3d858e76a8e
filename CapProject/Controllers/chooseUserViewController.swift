//
//  chooseUserViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/6/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class chooseUserViewController: UIViewController {

    
    @IBOutlet weak var studentButton: UIButton!
   
    @IBOutlet weak var teacherButton: UIButton!
    
    var teacherSelected = false
    var studentSelected = false
    
    
    @IBAction func studentButtonTapped(_ sender: Any) {
        let login = "login"
        Helpers.studentSelected = true
        performSegue(withIdentifier: login, sender: self)
    }
    
    
    @IBAction func teacherButtonTapped(_ sender: Any) {
        let login = "login"
        Helpers.teacherSelected = true
        print("teacher choose")
        self.performSegue(withIdentifier: login, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Helpers.teacherSelected = false
        Helpers.studentSelected = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
