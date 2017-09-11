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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
