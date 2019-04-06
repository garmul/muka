//
//  ReceiptDetailHeadTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/15/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class ReceiptDetailHeadTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLogo: UIImageView!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var total_Items: UILabel!
    @IBOutlet weak var dateReceived: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
