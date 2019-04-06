//
//  OrderModel.swift
//  muka
//
//  Created by Gary Mullings on 2/16/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RealmSwift


class OrderModel {
   
    
    var orderItems =  [MealBaseType]()
    
    
    init() {
        loadData()
    }
    
    
    
    func loadData() {
        
        let db = Firestore.firestore()
        let realmDB = try! Realm()
        
        
        let docRef = db.collection("profile").document("gsmullings@gmail.com").collection("orders")
        
    
        docRef.getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let orderTable = OrderTable()
                    let orderItemsList = List<MealBaseTypeDB>()

                    let data = document.data() as! Dictionary<String,Any>
                    
                    let restaurant = data["restaurant"]! as! String
                    let meal = data["meal"]! as! String
                //    let quantity = data["quantity"]! as! String
                    let status = data["status"]! as! String
                    let rating = data["rating"] as! String
                    let date = data["date"]! as! String
                    let items =   data["items"]! as! [Dictionary<String,Any>]
                    
                    
                    do {
                        
                        try  realmDB.write {
                          
                            realmDB.add(orderTable)
                            orderTable.date = date
                            orderTable.rating = rating
                            orderTable.status = status
                        }
                        
                        
                    } catch {
                        print("There was and error loading the database \(error)")
                        
                    }
                    
                   
               for  item in items {
                        
                    
                        let name = item["name"] as! String
                        let price = item["price"] as! String
                        let quantity = item["quantity"] as! String
                        
                        let itemx = MealBaseType(picture: "jamaicaDinner3",
                                                 description: "description",
                                                 name: name,
                                                 grams: "grams",
                                                 price: price,
                                                 mealType: "mealtype",
                                                 sortOrder: 1,
                                                 available: true,
                                                 quantity: Int(quantity)!)

                        
                        self.orderItems.append(itemx);
                        
                        let orderItem = MealBaseTypeDB()
                        orderItem.available = true
                        orderItem.name = name
                        orderItem.desc = "Description"
                        orderItem.grams = "grams"
                        orderItem.picture = "jamaicaDinner3"
                        orderItem.price = price
                        orderItem.quantity = Int(quantity)!
                        orderItem.sortOrder = 1
                        orderItem.mealType = "mealType"
                        
                       orderItemsList.append(orderItem)
                        
                do {
                 
                    try  realmDB.write {
                        orderTable.orderItems.append(orderItem)
                    }
                    
                    
                } catch {
                    print("There was and error loading the database \(error)")
                    
                }
                   
                    }
                    
                    
                    print("\(document.documentID) => \(document.data())")
                    

                    let restaurantdb = OrderRestaurantDB()
                    restaurantdb.address = "address"
                    restaurantdb.name = restaurant
                    restaurantdb.image = "image"
                    restaurantdb.rating = rating
                    restaurantdb.long = "0"
                    restaurantdb.lat = "0"
                    restaurantdb.flag = "flag"
                    restaurantdb.desc = "Desc"
                    
                     do {
                        print(realmDB.configuration.fileURL)
                        try  realmDB.write {
                             orderTable.restaurant = restaurantdb
                            // orderTable.orderItems.append(<#T##object: MealBaseTypeDB##MealBaseTypeDB#>)
                        }
                        
                        
                    } catch {
                        print("There was and error loading the database \(error)")
                        
                    }
                    
                Orders.sharedInstance.items.append(OrderType(status: status,
                                                                 rating : rating,
                                                                 date: date,
                                                                 restaurant: restaurantdb,
                                                                 orderItems: self.orderItems ) )
                    

                  
                    
                    
                }
                
    
            }
    
    
   
    
}


}

}
