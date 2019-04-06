//
//  ReceiptMainTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/14/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import SwipeCellKit

class ReceiptMainTableViewCell: SwipeTableViewCell {
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var numberOfItemsReceieved: UILabel!
    @IBOutlet weak var dateReceived: UILabel!
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
