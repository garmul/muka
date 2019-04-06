//
//  ScannedObjectsTableViewCell.swift
//  muka
//
//  Created by Gary Mullings on 3/3/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class ScannedObjectsTableViewCell: UITableViewCell {
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var customer: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
