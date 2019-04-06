//
//  Data.swift
//  muka
//
//  Created by Gary Mullings on 9/24/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class Data {
    var restaurant : model?
    let db = Firestore.firestore()
    
    
    
    
    func loadDataFromSource()  {
        db.collection("restaurant").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    
                    let data = document.data() as! Dictionary<String,String>
                    
                    let name = data["name"]!
                    let description = data["description"]!
                    let image = data["image"]!
                    let rating = Int(data["rating"]!)!
                    let address = data["Address"]!
                    
                    //     self.restaurants.append(Restaurant(name: name, description: description, image: image, rating: rating, address: address) )
                    //  self.downloadImage(imageLocation : image )
                    
                    print("\(document.documentID) => \(document.data())")
                }
                
                
            }
        }

   
     
        
   
    
    
    }
    
    
    
}



