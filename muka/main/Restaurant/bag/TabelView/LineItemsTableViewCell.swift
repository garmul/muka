//
//  LineItemsTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/28/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class LineItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var lineTotal: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemWeight: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(itemLabel : String, itemPrice : String, itemQuantity : Int, lineTotal : String)  {
        self.itemLabel.text = itemLabel
        self.itemPrice.text = itemPrice
        self.itemQuantity.text = String(itemQuantity)
        self.lineTotal.text = lineTotal
     }
    
    @IBAction func minusQuantity(_ sender: Any) {
        itemQuantity.text = "\(Int(itemQuantity.text!)! - 1)"
        lineTotal.text =  "\(Float((Int(itemQuantity.text!)!))  * Float(itemPrice.text!)!)"
    }
    
    @IBAction func addQuantity(_ sender: UIButton) {
        itemQuantity.text = "\(Int(itemQuantity.text!)! + 1)"
        lineTotal.text =  "\(Float((Int(itemQuantity.text!)!))  * Float(itemPrice.text!)!)"
        
    }
    
    
    
}
