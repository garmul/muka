//
//  ReceiverTypeTableViewCell.swift
//  muka
//
//  Created by Gary Mullings on 3/1/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class ReceiverTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var receiverType: UILabel!
    @IBOutlet weak var receiverImage: UIImageView!
    
 
    
    @IBOutlet weak var ReceiverTypeSelected: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
