//
//  MessageMainTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class MessageMainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var customer: UILabel!
    
    @IBOutlet weak var messageDate: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       customer.text = customer.text?.uppercased()    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
