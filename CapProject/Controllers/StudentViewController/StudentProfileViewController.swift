//
//  StudentProfileViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/12/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class StudentProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var username: UITextField!
   
    @IBOutlet weak var educationLevel: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func changeImage(_ sender: Any) {
        print(10)
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
    
    
    
    
    @IBAction func PickerViewButtonTapped(_ sender: Any) {
        
        // take student level using ActionSheetPicker
        let level = ["undergraduate","graduate","Bachelor","Master"]
        
        self.educationLevel.allowsEditingTextAttributes = false
        
        ActionSheetStringPicker.show(withTitle: "Student Level", rows: level, initialSelection: 1, doneBlock: {
            
            picker, indexes, values in
        
            self.educationLevel.text = values as? String
            return
            
        }, cancel: {ActionSheetStringPicker in return }, origin: sender)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {

        //set current student info
//        Student.current.level                = self.educationLevelLabel.text
//        Student.current.firstName            = self.firstName.text
//        Student.current.lastName             = self.lastName.text

        // update student in the firebase
        NetworkConstant.Student.UpdateFirstName(firstName: firstName.text)
        NetworkConstant.Student.UpdateLastName(lastName: lastName.text)
        NetworkConstant.Student.UpdateLevel(level: educationLevel.text)
        NetworkConstant.Student.UpdateUsername(withUsername: username.text!)
        NetworkConstant.Student.UpdateLevel(level: self.educationLevel.text)
        NetworkConstant.Student.UpdatephoneNumber(withNumber: Int(self.phoneNumber.text!)!)
         PictureStorageServices.createProfilePicture(for: self.profilePicture.image!)
        //call the main page
        self.viewDidAppear(true)
        let initialVC = UIStoryboard.initialViewController(for: .main)
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
