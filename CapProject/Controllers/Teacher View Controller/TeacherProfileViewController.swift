//
//  TeacherProfileViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/22/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TeacherProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    let teacher = Teacher()
    
    
    @IBAction func changeImage(_ sender: Any) {
        
        self.profilePicture.isHighlighted = true
        
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupProfileImage(){
        // self.profilePicture.translatesAutoresizingMaskIntoConstraints = false
        self.profilePicture.contentMode = .scaleAspectFit
        self.profilePicture.isUserInteractionEnabled = true
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.profilePicture.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }

    
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        // prepare to set Current Teacher
        teacher.firstName = self.firstName.text!
        teacher.lastName = self.lastName.text!
        teacher.username = self.userName.text!
        
        Teacher.setCurrent(teacher: teacher, WritetoTeacherDefault: true)
        NetworkConstant.Teacher.updateFirstName(firstname: firstName.text!)
        NetworkConstant.Teacher.updateLastName(lastname: lastName.text!)
        NetworkConstant.Teacher.updateUsername(withUsername: userName.text!)
        
        NetworkConstant.Teacher.updateNumber(withNumber: Int(self.phoneNumber.text!)!)
        
        //call the main page
        let initialVC = UIStoryboard.initialViewController(for: .Teachermain)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupProfileImage()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
