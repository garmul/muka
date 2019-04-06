//
//  Loadrestaurant.swift
//  muka
//
//  Created by Gary Mullings on 3/13/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import Foundation
import FirebaseFirestore


class Loadrestaurant {
    
    
    func Load()  {
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("restaurant")
        

        
        for _ in  1...100 {
            
            //TODO: Need to fix
            
            docRef.document().setData([ "Address": "1 love Street",
                                         "description": "The best Restaurant In Jones Town",
                                         "flag": "jamaica" ,
                                         "image": "JamrockDelights/oneLove.png",
                                         "lat": "33.749099",
                                         "long" : "-84.213531",
                                         "name" : "One Love Restaurant",
                                        "rating" : "4.9"
                ])
            
  
                }
    
    
    }
    
    
}




