//
//  ProfileTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/26/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import CoreGraphics


class ProfileTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileLineImage: UIImageView!
    
    @IBOutlet weak var counter: UILabel_Badge!
    @IBOutlet weak var backCircle: UIImageView!
    @IBOutlet weak var profileLineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
