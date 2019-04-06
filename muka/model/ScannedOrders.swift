//
//  ScannedOrders.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/14/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation


final class ScannedOrders {
    
    var items =  [orderString]()
    var hasReceiver = false
    
    static let sharedInstance = ScannedOrders()
    
    private init() {
       
    }
    
    func addItem(item : orderString)  {
        
        self.items.append(item)
        
    }
    
    func removeItem(itemIndex : Int)  {
        self.items.remove(at: itemIndex)
    }
    
}
