//
//  Receipts.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/14/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation



struct ReceiptLineItems {
    let name : String
    let price : String
    let quantity : String
    
    
    init(quantity : String , price : String, name : String) {
        self.quantity = quantity
        self.price = price
        self.name = name
    }
}

struct Receipt {
    let restuarant : String
    let date : String
    let documentId : String
    
    let items : [ReceiptLineItems]?
    
    init(restaurant : String, date : String, documentId : String, items : [ReceiptLineItems]?) {
        
        self.restuarant = restaurant
        self.date = date
        self.documentId = documentId
        self.items = items
        
    }
    
}




