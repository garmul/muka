//
//  OrderType.swift
//  muka
//
//  Created by Gary Mullings on 10/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
struct OrderType {
    var status : String
    var date : String
    var rating : String
    var restaurant : OrderRestaurantDB
    var orderItems : [MealBaseType]
    
  
    init(status : String, rating : String , date : String, restaurant : OrderRestaurantDB, orderItems : [MealBaseType]) {
        self.status = status
        self.date = date
        self.restaurant = restaurant
        self.orderItems = orderItems
        self.rating = rating
    }
    
}
