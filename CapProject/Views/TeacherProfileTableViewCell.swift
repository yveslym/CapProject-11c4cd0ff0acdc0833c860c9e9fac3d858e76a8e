//
//  TeacherProfileTableViewCell.swift
//  CapProject
//
//  Created by Yves Songolo on 9/12/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TeacherProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var numberOfCourses: UILabel!
    @IBOutlet weak var teacherProfilePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
