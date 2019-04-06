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
import RealmSwift


class RestaurantModel {

   
    var restaurant = [Restaurant]()
    var locationManager = CLLocationManager()
    var userLocation : CLLocation?
    
    
    init() {
        loaddata()
        
    }
    

    
    func loaddata()  {
        
        let realmDB = try! Realm()
        
        let db = Firestore.firestore()
        
        let docRef =  db
            .collection("restaurant")
        
        
        docRef.getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                do {

                   try realmDB.write {
                          realmDB.delete(realmDB.objects(RestaurantDB.self))
                    }

                } catch {
                    print("Error deleting Restaurant Objects")

                }

                
               
                
                
               for document in querySnapshot!.documents {
                    
                    let data = document.data() as! Dictionary<String,String>
                    
                    let name = data["name"]!
                    let description = data["description"]!
                    let imagex = data["image"]!
                    let rating = data["rating"]!
                    let address = data["Address"]!
                    let lat = data["lat"]!
                    let long = data["long"]!
                    let flag = data["flag"]!
                    //     self.restaurants.append(Restaurant(name: name, description: description, image: image, rating: rating, address: address) )
                    //  self.downloadImage(imageLocation : image )
                    
                    print("\(document.documentID) => \(document.data())")
                    
                    
                    let store = Storage.storage()
                    let storeRef = store.reference(forURL: "gs://muka-5a505.appspot.com/\(imagex)")
                    
                    storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("error: \(error.localizedDescription)")
                        } else {
                            let image = UIImage(data: data!)
                     
                           
                                   self.restaurant.append(Restaurant(name: name, description: description, image: imagex, rating: rating, address: address, uiimage: image ?? UIImage(named: "jamaicaDinner3")!, lat : lat , long : long, flag: flag ))
                            
                            let restaurantTableData = RestaurantDB()
                            restaurantTableData.name = name
                            restaurantTableData.address = address
                            restaurantTableData.desc = description
                            restaurantTableData.flag = flag
                            restaurantTableData.lat = lat
                            restaurantTableData.long = long
                            restaurantTableData.rating = rating
                            restaurantTableData.image = "jamaicaDinner3"
                            
                            
                            do {
                                
                              try  realmDB.write {
                                    realmDB.add(restaurantTableData)
                                }
                                
                                
                            } catch {
                                print("There was and error loading the database \(error)")
                                
                            }
                            
                         
                            
                                    NotificationCenter.default.post(name: Notification.Name("didCompleteTask"), object: nil)                           // self.myImageView.image = image
                        }
                    
                    }
                    

            }
            
            
        }
   
           
            
        
} // loaddata
    
    



}

    func downloadImageUserFromFirebase(link : String) ->  UIImage? {
        
        var image : UIImage?
        
        let storageRef = Storage.storage().reference(forURL: "gs://muka-5a505.appspot.com/\(link)")
        
        storageRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
            if error == nil {
                
                if let imgData = data {
                    if let img = UIImage(data: imgData) {
                        print("got imagedata \(String(describing: imgData))")
                        //                        objectsToShare.append(img)
                        print("image downloaded")
                        image = img
                        
                    }
                }
            } else {
                print("ERROR DOWNLOADING IMAGE : \(String(describing: error))")
            }
        }
    
    return image
    }

}












