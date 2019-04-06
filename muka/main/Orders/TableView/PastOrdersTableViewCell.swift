//
//  PastOrdersTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/24/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit


class PastOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var CompanyLogo: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var company: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        CompanyLogo.layer.cornerRadius = CompanyLogo.frame.size.width / 2
       
        CompanyLogo.clipsToBounds = true
        CompanyLogo.layer.borderWidth = 2
        CompanyLogo.layer.borderColor = UIColor.black.cgColor
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
