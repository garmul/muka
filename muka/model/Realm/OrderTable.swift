//
//  File.swift
//  muka
//
//  Created by Gary Mullings on 3/20/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation
import RealmSwift

class OrderTable: Object {
    
   @objc dynamic  var status : String?
   @objc dynamic  var date : String?
   @objc dynamic   var rating : String?
   @objc dynamic   var restaurant : OrderRestaurantDB?
   var orderItems  = List<MealBaseTypeDB>()
}



