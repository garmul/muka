//
//  Meal.swift
//  muka
//
//  Created by Gary Mullings on 9/23/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation



class Meal {
    var picture : String
    var description : String
    var name : String
    var grams  :  String
    var price : String
    var mealType : String
    
    
    init(picture : String, description : String, name : String, grams :  String, price : String, mealType : String) {
        self.picture =  picture
        self.description = description
        self.name = name
        self.grams = grams
        self.price = price
        self.mealType = mealType
    }
    
    func toString()  {
        print("Picture : \(picture) Description : \(description) name : \(name) Grams : \(grams)")
    }
    
}
