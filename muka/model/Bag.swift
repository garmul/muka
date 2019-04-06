//
//  BagSharedInstance.swift
//  muka
//
//  Created by Gary Mullings on 9/29/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

//
//  orders.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/4/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
import UIKit

final class Bag {
    
    var items : OrderType?
    
    static let sharedInstance = Bag()
    
   
  
    func addItem(orderType : OrderType, mealBaseType : MealBaseType)  {
        
        self.items?.orderItems.append(mealBaseType)
        
    }
    
    func removeItem( index : Int)  {
        
        self.items?.orderItems.remove(at: index)
        
    }
    
    
    
}

