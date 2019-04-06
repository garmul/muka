//
//  DiscountModel.swift
//  muka
//
//  Created by Gary Mullings on 2/21/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

//
//  MessageModel.swift
//  muka
//
//  Created by Gary Mullings on 10/22/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//


import Foundation
import NotificationCenter
import FirebaseFirestore
import FirebaseStorage
import CoreLocation


class DiscountModel {
    
  
    var items = [Discount]()
    
    init() {
        loaddata()
        
    }
    
    
    
    func loaddata()  {
        
        let db = Firestore.firestore()
        
        let docRef =  db
            .collection("profile").document("gsmullings@gmail.com")
            .collection("discount")
        
        
        
        docRef.getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            
            } else {
                
                
              
                var tempDiscountLog = [DiscountLog]()
                
                
                for document in querySnapshot!.documents {
                    
                    
                    let data = document.data() as! Dictionary<String,String>
                    
                    let restaurant = data["name"]!
                    
                    
                    let restaurantDiscountRef = docRef.document(restaurant).collection("Discount")
                    
                    
                    restaurantDiscountRef.getDocuments() { (querySnapshot2, err) in
                        
                         if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            for document in querySnapshot2!.documents {
                                
                                let data = document.data() as! Dictionary<String,String>
                                
                                let date = data["date"]!
                                let discount = data["discount"]!
                                
                               tempDiscountLog.append(DiscountLog(date: date, discount: discount))
                                
                            }
                            
                         }
                        
                        
                        
                        ////
                                
                    }
                    
                    let discount = Discount(name: restaurant, discountLog: tempDiscountLog)
                     
                  
                    Discounts.sharedInstance.addItem(item: discount)
                    
                    //     self.discounts.append(Discount(restaurant: restaurant, date: date, discount: discount))
                    
                    print("\(document.documentID) => \(document.data())")
                    
                    
                    //                    let store = Storage.storage()
                    //                    let storeRef = store.reference(forURL: "gs://muka-5a505.appspot.com/\(companyLogo)")
                    //
                    //                    storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    //                        if let error = error {
                    //                            print("error: \(error.localizedDescription)")
                    //                        } else {
                    //                            let image = UIImage(data: data!)
                    //
                    //
                    ////                            self.restaurant.append(Restaurant(name: name, description: description, image: imagex, rating: rating, address: address, uiimage: image ?? UIImage(named: "jamaicaDinner3")!, lat : lat , long : long, flag: flag ))
                    //
                    NotificationCenter.default.post(name: Notification.Name("updateMessages"), object: nil)                           // self.myImageView.image = image
                    //                        }
                    //
                    //                    }
                    
                    
                }
                
                
            
                
            }
            
            
            
            
        } // loaddata
        
         items =  Discounts.sharedInstance.items
        
        
        
    }
    
    
    
}













