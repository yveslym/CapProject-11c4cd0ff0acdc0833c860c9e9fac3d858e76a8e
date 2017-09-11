//
//  TeacherLIstOfCourseTableViewCell.swift
//  CapProject
//
//  Created by Yves Songolo on 8/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TeacherLIstOfCourseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classname: UILabel!
    
    @IBOutlet weak var classSection: UILabel!
    
    @IBOutlet weak var numberofStudent: UILabel!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
