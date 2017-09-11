//
//  StudentResourceViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/10/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import SwiftQRCode

class StudentResourceViewController: UIViewController {

    @IBOutlet weak var returnButton: UIBarButtonItem!
    @IBOutlet weak var barcodeView: UIImageView!
    @IBOutlet var cameraview: UIView!
    let scanner = QRCode()
    let student = Student(withEmail:"yves@gmail.com", password: "songolo93")
    
    

    @IBAction func unwindToHomePageTableViewController(_ segue: UIStoryboardSegue) {
        
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    @IBAction func createCourse(_ sender: Any) {
        
        }
    
    
    @IBAction func completed(_ sender: Any) {
            }
    
    @IBAction func scanCode(_ sender: Any) {
        
        
    }
    

    @IBAction func AddNewcourse(_ sender: Any) {
        
       self.performSegue(withIdentifier: "completed", sender: self)
    }
}
