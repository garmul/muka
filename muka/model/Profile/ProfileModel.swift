//
//  ProfileModel.swift
//  muka
//
//  Created by Gary Mullings on 10/29/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//




import Foundation
import NotificationCenter
import FirebaseFirestore
import FirebaseStorage
import CoreLocation


class ProfileModel {
    
    var profile : Profile?
    
    
    init() {
        loaddata()
        
    }
    
    func loaddata()  {
        
        let db = Firestore.firestore()
        
        let docRef =  db
            .collection("profile").document("gsmullings@gmail.com")
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
               
                let data = document.data() as! Dictionary<String,String>
                
                let fname = data["fname"]!
                let lname = data["lname"]!
             //   let user = data["user"]!
                
                print(fname)
                print(lname)
                
             
                self.profile =  Profile(userFname: fname, userLname: lname)
                NotificationCenter.default.post(name: Notification.Name("updateMyProfile"), object: nil)
                
            
            } else {
                print("Document does not exist")
            }
        }
        
      
        
        } // loaddata
        
        
    }
    
    













