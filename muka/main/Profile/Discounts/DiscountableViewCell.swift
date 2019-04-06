//
//  DiscountableViewCell.swift
//  muka
//
//  Created by Gary Mullings on 2/20/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class DiscountableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var restaurantDate: UILabel!
    
    @IBOutlet weak var restaurantDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
