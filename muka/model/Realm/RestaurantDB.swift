//
//  RestaurantDB.swift
//  muka
//
//  Created by Gary Mullings on 3/14/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation
import RealmSwift


class RestaurantDB : Object {
    @objc dynamic var name : String?
    @objc dynamic var desc : String?
    @objc dynamic var image : String?
    @objc dynamic var rating : String?
    @objc dynamic var address : String?
    @objc dynamic var lat : String?
    @objc dynamic var long : String?
    @objc dynamic var flag : String?
    
    // var meals : [Meal]
   
}



