//
//  Dessert.swift
//  muka
//
//  Created by Gary Mullings on 10/2/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation



class Dessert {
    var picture : String
    var description : String
    var name : String
    var price  :  String
    
    
    init(picture : String, description : String, name : String, price :  String) {
        self.picture =  picture
        self.description = description
        self.name = name
        self.price = price
    }
    
    func toString()  {
        print("Picture : \(picture) Description : \(description) name : \(name) Grams : \(price)")
    }
    
}
