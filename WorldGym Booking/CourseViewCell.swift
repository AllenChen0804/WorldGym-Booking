//
//  CourseViewCell.swift
//  WorldGym Booking
//
//  Created by 陳永展 on 2019/5/18.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class CourseViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var coach: UILabel!
    
    @IBOutlet weak var training: UILabel!
    
  
    @IBOutlet weak var day: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
