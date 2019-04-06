//
//  TotalTableViewCell.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/28/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Stripe
import NotificationCenter


protocol updateAfterPlacedOrder {
    func updateTableView(total : Int)
}
class TotalTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var totalDollars: UILabel!
    
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
         calculateTotal()
        
       NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
        // Initialization code
    }

    
    override func prepareForReuse() {
        calculateTotal()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

    @IBAction func placeOrder(_ sender: UIButton) {
        
  
        
    }
    
   
    @objc func onDidReceiveData(_ notification: Notification)
    {
        
        calculateTotal()
    }
    

    func calculateTotal() {
        let mealBag = Bag.sharedInstance
        var total : Float = 0.0
        
        if let mealBagItems = mealBag.items?.orderItems {
            for item in mealBagItems {
                total = total + (Float(item.price)! * Float(item.quantity))
                }
            
                totalDollars.text = String(format:"%.2f", total)
            }
    }
    
    
}



