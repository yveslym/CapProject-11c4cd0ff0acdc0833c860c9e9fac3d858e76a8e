//
//  TeacherListOfStudentTableViewCell.swift
//  CapProject
//
//  Created by Yves Songolo on 9/13/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TeacherListOfStudentTableViewCell: UITableViewCell {
   
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var AttendanceMark: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
