//
//  QRCodeViewController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import SwiftSignatureView
import FirebaseFirestore

class CreateReceiptViewController: UIViewController { //},processScannedData, processPersonalData, UITableViewDelegate, UITableViewDataSource {
    
    let userDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var ordersContainer: UIView!
    
    @IBOutlet weak var receiverContainer: UIView!
    
    

    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    

    
    var model = ScannedOrders.sharedInstance.items
   


    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0 :
                ordersContainer.isHidden = false
                receiverContainer.isHidden = true
            
    
        case 1 :
            
            ordersContainer.isHidden = true
            receiverContainer.isHidden = false

            
        default:
            break
        }
        
    }
    

   
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let  QRScannerVC  = segue.destination as? QRScannerController {
//            QRScannerVC.delegate = self
//        }
//
//        //showScanner
//
//        if let  QRPersonalScannerVC  = segue.destination as? QRPersonalScannerController {
//            QRPersonalScannerVC.delegate = self
//        }
//
//
//    }
//
    
    
//    func dataToBeProcessed() {
//
//        if model.items.count > 0 {
//            scannedOrder.isHidden = false
//            scanForOrdersLabel.isHidden = true
//            scannedOrder.reloadData()
//        }
//
//
//    }
//
//
//    func personalDataToBeProcessed(person : Person) {
//
//       ordersReceivedBy.text = "\(person.name) from \(person.company)"
//
//    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersContainer.isHidden = false
        receiverContainer.isHidden = true
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(80.0)
//    }
//
    // MARK: - Navigation

 
  
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//
//            self.model.items.remove(at: indexPath.row)
//            tableView.reloadData()
//
//        }
//
//        return [delete]
//
//    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
//    @IBAction func clearSignatureButtonPressed(_ sender: UIButton) {
//        signatureView.clear()
//        signatureView.signature
//    }
//
    
    
//    struct orderString {
//        let orderNo : String
//        let orderItem : String
//        let orderDate : String
//        let restuarant : String
//        let dish : String
//        let quantity : String
//        let price : String
//    }
//
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        
        
      
        
        
        let model = ScannedOrders.sharedInstance
        let hasReceiver = ScannedOrders.sharedInstance.hasReceiver
        
        
        guard model.items.count > 0 && hasReceiver  else {
           
            let alert =  UIAlertController(title: "Order Data Missing", message: "Enter orders and receiver information", preferredStyle: .alert)
            
            let OkButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(OkButton)
            
            
            self.present(alert, animated: true, completion: nil)
            
            
            return
        }
        
        
        let db = Firestore.firestore()
        
        
     let docRef1 = db.collection("profile")
            .document("gsmullings@gmail.com")
            .collection("messages")
        
        
        let docRef = db.collection("profile")
            .document("gsmullings@gmail.com")
            .collection("receipts")
        
        
       
        let dateformater = DateFormatter()
        dateformater.dateFormat = "MMM d"
        let date = dateformater.string(from: Date())
        
        var itemsDictionary =  [[String:String]]()
        
     
        
        for item in  model.items {
            
          itemsDictionary.append( ["name":item.dish, "price" :item.price, "quantity" : item.quantity])
      
        }
        
    
     
        
        for item in  model.items {
            
            //TODO: Need to fix
            
            docRef1.document().setData([ "companyLogo": item.orderNo,
                                         "companyName": item.restuarant,
                                         "messageDate": "\(date)" ,
                                         "messageDetail": "\(item.quantity)  x  \(item.dish) was purchased at $\(item.price) price  and picked up by xyz",
                                         "messageHeading": "Your \(item.restuarant) order has been delivered",
                                         "viewed" : "0"
                ])
       
           }
            
      
            docRef.document().setData([ "date": "\(date)"  ,
                                        "companyName": model.items[0].restuarant,
                                        "companyLogo": "nologo",
                                        "items": itemsDictionary //[["name":item.dish, "price" :item.quantity, "quantity" : item.quantity]]
                ])
            
            
          ScannedOrders.sharedInstance.items.removeAll()
          ScannedOrders.sharedInstance.hasReceiver = false
        
        
  
        let alert =  UIAlertController(title: "Order Status", message: "Your Order Receipt as been saved!", preferredStyle: .alert)
        
        let OkButton = UIAlertAction(title: "OK", style: .default) { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        alert.addAction(OkButton)
        
        
        self.present(alert, animated: true, completion: nil)
   
      
           
            print("Add to Database")
//            docRef.document().setData([ "date": item.orderDate,
//                                        "meal": item.orderItem,
//                                        "quantity": item.quantity,
//                                        "restaurant": item.restuarant,
//                                        "status": "processing",
//                                        "items": ["name":"Fried Chicken", "price" :"5.99", "quantity" : "65"]
//                ])
        
        
        
            
        }
        
        
    }
    
    
    
   
  

