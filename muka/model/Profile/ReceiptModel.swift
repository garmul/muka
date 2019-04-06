//
//  MessageModel.swift
//  muka
//
//  Created by Gary Mullings on 10/22/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
//
//  model.swift
//  muka
//
//  Created by Gary Mullings on 9/25/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//


import Foundation
import NotificationCenter
import FirebaseFirestore
import FirebaseStorage
import CoreLocation


class ReceiptModel {
    
    
    
    var receipt = [Receipt]()
    
    
    
    init() {
        loaddata()
        
    }
    
    
    
    func loaddata()  {
        
        let db = Firestore.firestore()
        
        let docRef =  db
            .collection("profile").document("gsmullings@gmail.com")
            .collection("receipts")
        
   
        
        docRef.getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    var receiptLineItems = [ReceiptLineItems]()
                    
                    let data = document.data() as! Dictionary<String,Any>
                    
                    let companyLogo = data["companyLogo"]! as! String
                    let companyName = data["companyName"]! as! String
                    let date = data["date"]! as! String
                    let items =   data["items"]! as! [Dictionary<String,Any>]
                    let documentId = document.documentID
                    
                    
                    for  item in items {
                        
                        
                        let name = item["name"] as! String
                        let price = item["price"] as! String
                        let quantity = item["quantity"] as! String
                        
                        let itemx =  ReceiptLineItems(quantity: quantity, price: price, name: name)
                    
                        
                        receiptLineItems.append(itemx);
                        
                    }
                    
                        
                    self.receipt.append(Receipt(restaurant: companyName,
                                                date: date,
                                                documentId: documentId, items: receiptLineItems))
                    
                    print("\(document.documentID) => \(document.data())")
                    print("Receipts Printed")
                    
                 
                    NotificationCenter.default.post(name: Notification.Name("updateReceipts"), object: nil)                           //
                    
                    
                }
                
                
            }
            
            
            
            
        } // loaddata
        
        
        
        
        
    }
    
    
    
}





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







