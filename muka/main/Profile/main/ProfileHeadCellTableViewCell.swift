//
//  ProfileHeadCellTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/26/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class ProfileHeadCellTableViewCell: UITableViewCell {

    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var UserPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UserPicture.layer.cornerRadius = UserPicture.frame.size.width / 2
        UserPicture.clipsToBounds = true
        UserPicture.layer.borderWidth = 2
        UserPicture.layer.borderColor = UIColor.black.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
