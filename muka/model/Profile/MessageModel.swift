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


class MessageModel {
    
    
    
    var messages = [Message]()
  
    
    init() {
        loaddata()
        
    }
    
    
    
    func loaddata()  {
        
        let db = Firestore.firestore()
      
        let docRef =  db
            .collection("profile").document("gsmullings@gmail.com")
            .collection("messages")
        
   
        
        docRef.getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let data = document.data() as! Dictionary<String,String>
                    
                    let documentID = document.documentID
                    let companyLogo = data["companyLogo"]!
                    let companyName = data["companyName"]!
                    let messageDate = data["messageDate"]!
                    let messageDetail = data["messageDetail"]!
                    let messageHeading = data["messageHeading"]!
                    let messageViewed = data["viewed"]!
                   
                    self.messages.append(Message(documentID : documentID,
                                                 company: companyName,
                                                 customerEmail: "Admin",
                                                 subject: messageHeading,
                                                 date: messageDate,
                                                 message: messageDetail,
                                                 viewed : messageViewed))
           
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
        
        
        
        
        
    }
    

    
}












