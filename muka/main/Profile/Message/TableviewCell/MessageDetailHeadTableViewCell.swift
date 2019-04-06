//
//  MessageDetailHeadTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class MessageDetailHeadTableViewCell: UITableViewCell {

    @IBOutlet weak var customer: UILabel!

    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
