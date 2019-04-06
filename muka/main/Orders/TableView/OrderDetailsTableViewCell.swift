//
//  OrderDetailsTableViewCell.swift
//  muka
//
//  Created by Gary Mullings on 2/17/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(productName : String, productPrice : String, productQuantity : String )  {
        self.productName.text = productName
        self.productPrice.text = productPrice
        self.productQuantity.text = productQuantity
    }
    
    
}
