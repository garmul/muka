//
//  Discount.swift
//  muka
//
//  Created by Gary Mullings on 2/21/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation

final class Discounts {
    
    var items = [Discount]()
    
    static let sharedInstance = Discounts()
    
    private init() {
        
        
    }
    
    func addItem(item : Discount)  {
        
        self.items.append(item)
        
    }
    
    func removeItem( index : Int)  {
        
        self.items.remove(at: index)
        
    }
    
    
    
}

struct Discount {
    let name : String
    let discountLog : [DiscountLog]
}

struct DiscountLog {
    let date : String
    let discount : String
}
