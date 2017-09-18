//
//  LoginViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
  
    @IBAction func cancel(_ sender: Any) {
        
        Helpers.studentSelected = false
        Helpers.teacherSelected = false
        let initialVC = UIStoryboard.initialViewController(for: .login)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // login student
        
        if Helpers.studentSelected{
            
            StudentServices.SignInStudent(email: email.text, password: password.text, completion: {(student) in
                
                if student != nil
                {
                    let initialVC = UIStoryboard.initialViewController(for: .main)
                    self.view.window?.rootViewController = initialVC
                    self.view.window?.makeKeyAndVisible()
                }
                else {
                    print(" COULD NOT LOGIN")
                }
                
            })//end of login
        }
            
            // login teacher
        else if Helpers.teacherSelected {
            
            TeacherServices.SignIn(withEmail: email.text!, password: password.text!, completion: {(teacher) in
                if teacher != nil{
                    print("teacher login and set as current teacher")
                    let initialVC = UIStoryboard.initialViewController(for: .Teachermain)
                    self.view.window?.rootViewController = initialVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
                else{
                    print("couldn't login teacher")
                }
            })
        }
            
        else{
            print ("both student and teacher was false.. which is not good.. fuck..")
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "register", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


















