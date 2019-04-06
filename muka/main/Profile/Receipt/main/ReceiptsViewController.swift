//
//  ReceiptsViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/14/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwipeCellKit

class ReceiptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
 
    

    

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        let deleteAction = SwipeAction(style: .destructive, title: nil) { (action , indexPath) in
            
            
            let alert = UIAlertController(title: "Delete Receipts", message: "Are you sure you want to Delete Receipt?", preferredStyle: .actionSheet)
            
            
            let OKbutton = UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
                
                self.model.receipt.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
              //  tableView.reloadData()
                
                print("Delete Receipt")
            })
            
            
            let CancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            
            alert.addAction(OKbutton)
            alert.addAction(CancelButton)
            
            
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
        
        deleteAction.image = UIImage(named: "baseline_delete_forever_white_18pt_3x")
       
        
        return [deleteAction]
        
        
    }
    
   
  //  let model = Receipts.sharedInstance
    let model = ReceiptModel()
    
    var receiptLineItems  = [ReceiptLineItems]()
    
    var selectedOrder : IndexPath?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.receipt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as! ReceiptMainTableViewCell
        
        cell.delegate = self
        
        cell.companyName.text = model.receipt[indexPath.row].restuarant
        cell.dateReceived.text = model.receipt[indexPath.row].date
    
        var numberOfItems = 0
        var totalPrice = 0.0
        
        
        if let items = model.receipt[indexPath.row].items  {
            
         
          
            for item in items {
                
                totalPrice = totalPrice + Double(item.price)! * Double(item.quantity)!
                numberOfItems = numberOfItems + Int(item.quantity)!
           
            }
            
            
            
        }
        
        cell.numberOfItemsReceieved.text = "\(numberOfItems) item(s) for $\(String(format: "%.2f", arguments: [totalPrice]))"
        
        
        return cell
        
    }
  

    @IBOutlet weak var receiptsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      NotificationCenter.default.addObserver(self, selector: #selector(didReceiveReceipts(_:)), name: .didReceiveReceipts, object: nil)
      
        receiptsTableView.register(UINib(nibName: "ReceiptMainTableViewCell", bundle: nil), forCellReuseIdentifier: "receiptCell")
        
        receiptsTableView.delegate = self
        receiptsTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        selectedOrder = indexPath
        performSegue(withIdentifier: "ReceiptDetails", sender: nil)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let receiptDetailVC = segue.destination as? ReceiptDetailsViewController {
            
            
        //    loadReceiptDetails()
            
            let receipt = Receipt(restaurant: model.receipt[selectedOrder!.row].restuarant ,
                                  date: model.receipt[selectedOrder!.row].date,
                                  documentId: model.receipt[selectedOrder!.row].documentId,
                                  items: model.receipt[selectedOrder!.row].items)
            
            receiptDetailVC.model = receipt
            
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
   
//    func loadReceiptDetails()  {
//
//        let db = Firestore.firestore()
//
//        let docRefseb =  db
//            .collection("profile").document("gsmullings@gmail.com")
//            .collection("receipts").document("2ep3ztdM0PSCCoeXWXvy") /// fix
//            .collection("item")
//
//
//        docRefseb.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                self.receiptLineItems.removeAll()
//                for document in querySnapshot!.documents {
//
//                    let data = document.data() as! Dictionary<String,String>
//
//                    let itemPicture = data["itemPicture"]!
//                    let itemPrice = data["itemPrice"]!
//                    let personWhoOrdered = data["personWhoOrdered"]!
//                    let itemName = data["itemName"]!
//
//
//                    self.receiptLineItems.append(ReceiptLineItems(item: itemName, price: itemPrice, customer: personWhoOrdered))
//
//
//                    NotificationCenter.default.post(name: Notification.Name("updateReceiptsDetails"), object: nil)
//                }
//            }
//        }
//    }
    
    
    
    @objc func didReceiveReceipts(_ notification: Notification)
    {
        
        // restuarantLoadingIndicator.stopAnimating()
        //   s restuarantLoadingIndicator.isHidden = true
        receiptsTableView.reloadData()
    }
    
    
}
