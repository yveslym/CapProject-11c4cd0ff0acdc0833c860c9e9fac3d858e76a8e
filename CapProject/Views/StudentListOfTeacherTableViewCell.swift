//
//  StudentListOfTeacherTableViewCell.swift
//  CapProject
//
//  Created by Yves Songolo on 8/25/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class StudentListOfTeacherTableViewCell: UITableViewCell {

    @IBOutlet weak var TeacheName: UILabel!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var Section: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
