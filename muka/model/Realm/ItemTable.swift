//
//  ItemTable.swift
//  muka
//
//  Created by Gary Mullings on 3/20/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation
import RealmSwift


class ItemTable: Object {
    
    @objc dynamic var picture : String?
    @objc dynamic var desc : String?
    @objc dynamic var name : String?
    @objc dynamic var grams  :  String?
    @objc dynamic var price : String?
    @objc dynamic var mealType : String?
    @objc dynamic var available : Bool = false
    @objc dynamic var sortOrder: Int =  0
    @objc dynamic var quantity : Int = 1

}
