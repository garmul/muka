//
//  Category.swift
//  muka
//
//  Created by Gary Mullings on 3/13/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation
import RealmSwift



class Category: Object {
  @objc dynamic var name = ""
  let items = List<Item>()
    
}
