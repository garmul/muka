//
//  BagViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/25/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Stripe
import NotificationCenter
import FirebaseFirestore

class BagViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, STPAddCardViewControllerDelegate  {
    
    let bag = Bag.sharedInstance
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var noItemsList: UILabel!
    
    
    @IBOutlet weak var ordersToBePlacedTableView: UITableView!
    
    
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bagitems = bag.items {
        navBar.topItem?.title   =  bagitems.restaurant.name
           
        } else {
            
            navBar.topItem?.title = "BAG EMPTY"
        }
        
       
        
        ordersToBePlacedTableView.alpha = 0
        
        
        ordersToBePlacedTableView.register(UINib(nibName: "LineItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "lineItems")
        
        ordersToBePlacedTableView.register(UINib(nibName: "TotalTableViewCell", bundle: nil), forCellReuseIdentifier: "totalcell")
        
        
        
        ordersToBePlacedTableView.delegate = self
        ordersToBePlacedTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String: Int]
        {
            for (name, score) in data
            {
                print("\(name) scored \(score) points!")
            }
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return section == 0 ? bag.items?.orderItems.count ?? 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "lineItems", for: indexPath) as! LineItemsTableViewCell
            cell.updateCell(itemLabel: bag.items?.orderItems[indexPath.row].name ?? "No nAME",
                            itemPrice: bag.items?.orderItems[indexPath.row].price ?? "0.0",
                            itemQuantity: bag.items?.orderItems[indexPath.row].quantity ?? 0,
                            lineTotal:  String(Float(bag.items?.orderItems[indexPath.row].quantity ?? 0) *
                                Float(bag.items?.orderItems[indexPath.row].price ?? "0.0")!)
                
            )
            
            return cell
            
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalcell", for: indexPath) as! TotalTableViewCell
            
            var total : Float = 0.0
            
            if let bagItems =  bag.items {
               
                for  item in bagItems.orderItems {
                    total = total + Float(item.price)! * Float(item.quantity)
                    
                }
                
            }
          
           cell.totalDollars.text = String(format:"%.2f", total)
          
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
   }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if indexPath.section == 0  {
            let tableViewRowActions = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                print("The row : \(indexPath.row)")
                print("The section : \(indexPath.section)")
                
                self.bag.removeItem(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
               // tableView.reloadData()
                NotificationCenter.default.post(name: Notification.Name("updateBagCount"), object: nil)
                self.tableviewVisibilityCheck()
                
            }
            
            return [tableViewRowActions]
        } else {
            return nil
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? true : false
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    @IBAction func payButtonPressed(_ sender: UIBarButtonItem) {
        
//        let addCardViewController = STPAddCardViewController()
//        addCardViewController.delegate = self
//
//        // Present add card view controller
//        let navigationController = UINavigationController(rootViewController: addCardViewController)
//        present(navigationController, animated: true)
        
        
        let orders = Orders.sharedInstance
   
//TODO: ADD IN FIREBASE
        
        if bag.items != nil {
            orders.addItem(orderType : bag.items!)
            
            let db = Firestore.firestore()
            
            let docRef = db.collection("profile")
                .document("gsmullings@gmail.com")
                .collection("orders")
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let stringOutput = dateFormatter.string(from: date)
            
            
            docRef.document().setData([ "date": stringOutput,
                                        "meal":"No meal",
                                        "quantity": "item.quantity",
                                        "restaurant": bag.items?.restaurant.name,
                                        "status": "processing",
                                        "rating" : "0",
                                        "items": [["name":"Fried Chicken", "price" :"5.99", "quantity" : "65"]]
                ])
            
   
        
        
        }
        
        
       
        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let bagitems = bag.items {
            navBar.topItem?.title   =  bagitems.restaurant.name
            
        } else {
            
            navBar.topItem?.title = "BAG EMPTY"
        }
        
        tableviewVisibilityCheck()
    }
    
    
    func tableviewVisibilityCheck()  {
        
        
        if let bagitems = bag.items {
            
            if bagitems.orderItems.count  > 0 {
                ordersToBePlacedTableView.alpha = 1
            } else
            {
                ordersToBePlacedTableView.alpha = 0
            }
            
        }
        
        
    }
    
    
    
    
}
