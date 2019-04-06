//
//  MealsTableViewCell.swift
//  muka
//
//  Created by Gary Mullings on 9/20/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
   
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var mealPicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemDescription.sizeToFit()
        itemDescription.numberOfLines = 0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }
    
    func updateCell(itemDescription : String, price : String, weight : String, mealPicture : String, item : String) {
        self.itemDescription.text = itemDescription
        self.price.text = "\(price)"
        self.weight.text = weight
        self.item.text = item.uppercased()
       
    }
    
    func disableControls()  {
        self.itemDescription.isEnabled = false
        self.price.isEnabled = false
        self.weight.isEnabled = false
        self.item.isEnabled = false
        
        self.itemDescription.textColor = UIColor.flatGray
        self.price.textColor = UIColor.flatGray
        self.weight.textColor = UIColor.flatGray
        self.item.textColor = UIColor.flatGray
        
    }
    
    
}
