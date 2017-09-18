//
//  RegisterViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
     @IBOutlet weak var loginButton: UIButton!
    
    /// function to check either the password and confirm password is the same
    /// if they are different return an error message and disable the login button
    /// if they are the same unlock the login button
    @IBAction func checkPW(_ sender: Any) {
        
        if self.password.text != self.confirmPassword.text{
            self.loginButton.isEnabled = false
            
            self.errorMessage.text = " Password Doesn't Match"
            self.errorMessage.textColor = .red
            self.errorMessage.isHidden = false
        }
        else{
            self.loginButton.isEnabled = true
            self.errorMessage.isHidden = true
        }

    }
    
        func checkPassword(){
        if self.password != self.confirmPassword{
            self.loginButton.isEnabled = false
            
            self.errorMessage.text = " Password Doesn't Match"
            self.errorMessage.textColor = .red
            self.errorMessage.isHidden = false
        }
        else{
            self.loginButton.isEnabled = true
            self.errorMessage.isHidden = true
        }
    }
    
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        if Helpers.studentSelected == true{
            
            StudentServices.createNewStudent(withEmail: email.text!, password: password.text, completion: {(student) in
                if student != nil{
                    print("student create")
                    self.performSegue(withIdentifier: "studentProfile", sender: self)
                }
            })
        }
        else if Helpers.teacherSelected == true{
            
            TeacherServices.createTeacher(withEmail: email.text!, password: password.text!, completion: {(teacher) in
                
                if teacher != nil{
                    print("teacher register")
                    
                    self.performSegue(withIdentifier: "teacherProfile", sender: self)
                }
                else{
                print("teacher not register")
                }
        })
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loginButton.isEnabled = false
        self.errorMessage.isHidden = true
    }
    
}
