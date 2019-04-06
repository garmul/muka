//
//  orders.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/4/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
import UIKit

final class Orders {
    
    var items : [OrderType] = [OrderType]()
    
    static let sharedInstance = Orders()
    
    private init() {
        

    }
    
    func addItem(orderType : OrderType)  {
        
        self.items.append(orderType)
        
    }
    
    func removeItem( index : Int)  {
        
        self.items.remove(at: index)
        
    }
    
    
    
}

