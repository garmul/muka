//
//  ReceiptDetailTailTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/15/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class ReceiptDetailTailTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItem: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var quantityNPrice: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
