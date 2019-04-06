//
//  MealBaseType.swift
//  muka
//
//  Created by Gary Mullings on 10/9/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation

class MealBaseType  {
    var picture : String
    var description : String
    var name : String
    var grams  :  String
    var price : String
    var mealType : String
    var available : Bool
    var sortOrder: Int
    var quantity : Int
    
    
    
    init(picture : String, description : String, name : String, grams :  String, price : String, mealType : String, sortOrder : Int, available : Bool, quantity : Int) {
        self.picture =  picture
        self.description = description
        self.name = name
        self.grams = grams
        self.price = price
        self.mealType = mealType
        self.sortOrder = sortOrder
        self.available = available
        self.quantity = quantity
    }
    
    func toString()  {
        print("Picture : \(picture) Description : \(description) name : \(name) Grams : \(grams)")
    
}
}
