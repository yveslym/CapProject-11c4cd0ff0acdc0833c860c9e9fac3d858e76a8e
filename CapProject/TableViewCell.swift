//
//  TableViewCell.swift
//  CapProject
//
//  Created by Yves Songolo on 8/26/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var course: UILabel!
    
    @IBOutlet weak var section: UILabel!
    
    @IBOutlet weak var number: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var change: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
