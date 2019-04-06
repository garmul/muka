//
//  Restaurant.swift
//  muka
//
//  Created by Gary Mullings on 9/25/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
import UIKit


struct Restaurant {
    var name : String
    var description : String
    var image : String
    var rating : String
    var address : String
    var uiimage : UIImage
    var lat : String
    var long : String
    var flag : String
    // var meals : [Meal]

    init(name : String, description : String , image : String , rating : String , address : String , uiimage : UIImage, lat : String, long : String, flag : String) {
        self.name = name
        self.description = description
        self.image = image
        self.rating = rating
        self.address = address
        self.uiimage = uiimage
        self.lat = lat
        self.long = long
        self.flag = flag
    }
}
