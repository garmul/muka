//
//  bagItem.swift
//  muka
//
//  Created by Gary Mullings on 9/29/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation

class BagItem {
    var itemType : ItemType
    var description : String
    var name : String
    var picture : String
    var price : String
    var quanity : Int
    var restauranant : String
    
    
    init(picture : String, description : String, name : String , price : String, itemType : ItemType, quantity : Int, restaurant : String) {
        self.picture =  picture
        self.description = description
        self.name = name
        self.price = price
        self.itemType = itemType
        self.quanity = quantity
        self.restauranant = restaurant
    }
    
    func toString()  {
        print("Picture : \(picture) Description : \(description) name : \(name) Price : \(price)")
    }
    
}
