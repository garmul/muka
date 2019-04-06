//
//  PastOrdersViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/24/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import NotificationCenter
import UserNotifications
import RealmSwift

class PastOrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate {
   
var selectedOrder : IndexPath?
    
    
    var resultList: Results<OrderTable>?
    var orders =  Orders.sharedInstance.items
    
 
    
    @IBOutlet weak var pastOrdersTableView: UITableView!
    
    @objc  func refreshOrders()  {
        
        if orders.count > 0 {
            pastOrdersTableView.alpha = CGFloat(1.0)
        } else {
            
            pastOrdersTableView.alpha = CGFloat(0.0)
            
        }
        
        pastOrdersTableView.reloadData()
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        UNUserNotificationCenter.current().delegate = self

        if orders.count == 0 {
            pastOrdersTableView.alpha = CGFloat(0.0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshOrders), name: NSNotification.Name(rawValue: "refreshOrders"), object: nil)
        
        pastOrdersTableView.delegate = self
        pastOrdersTableView.dataSource = self

        pastOrdersTableView.register(UINib(nibName: "PastOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "passOrderCell")
        // Do any additional setup after loading the view.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // orders.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passOrderCell", for: indexPath) as! PastOrdersTableViewCell
        
        
        if let results = resultList {
            
            for result in results {
                
                //      print("garyorder \(result)")
                
                print(
                    result.date,
                    result.orderItems.first?.price,
                    result.orderItems.first?.quantity,
                    result.orderItems.first?.name,
                    result.rating,
                    result.restaurant?.name
                )
            }
            
        }
       
      //  cell.CompanyLogo.image = orders.items[indexPath.row].companyLogo
        cell.company.text =   resultList?[indexPath.row].restaurant?.name
      //  cell.item.text    = resultList?[indexPath.row].restaurant?.name
        cell.status.text  =  resultList?[indexPath.row].status
        
        
        if cell.status.text == "Enroute" {
            cell.status.textColor = UIColor.red
        } else if cell.status.text == "Delivered" {
            cell.status.textColor = UIColor.green
            
        } else {
            cell.status.textColor = UIColor.blue
            
        }
       
        cell.date.text    =  resultList?[indexPath.row].date
        
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let reorder = UITableViewRowAction(style: .normal, title: "Reorder") { (action, indexPath) in
            print("Reorder")
        }
        reorder.backgroundColor = UIColor.blue


        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("Delete")
        }



        reorder.backgroundColor = UIColor.blue
        delete.backgroundColor = UIColor.red

        return [reorder,delete]

    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        selectedOrder = indexPath
      
        
        performSegue(withIdentifier: "showPreviewOrders", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let   OrderDetailsVC = segue.destination as? OrderDetailsViewController {
         
            OrderDetailsVC.order =   resultList?[selectedOrder!.row]
            
        
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        do {
            let realmDB = try? Realm()
            
            resultList = realmDB?.objects(OrderTable.self)
            
            
            
        } catch {
            print("\(error)")
        }
        
        pastOrdersTableView.reloadData()
        refreshOrders() 
    }
    
    
    

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([[.alert, .sound]])
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        
         orders =  Orders.sharedInstance.items
   pastOrdersTableView.reloadData()
              refreshOrders()
        
        let content =  UNMutableNotificationContent()
        content.title = "Title"
        content.body = "This is the body"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Test Indentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    
    }
    
    
    @IBAction func reload2(_ sender: UIButton) {
        
   
        
        orders =  Orders.sharedInstance.items
        
    pastOrdersTableView.reloadData()
              refreshOrders()
        
        
     let content =  UNMutableNotificationContent()
     content.title = "Title"
     content.body = "This is the body"
     content.sound = UNNotificationSound.default
     
     let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
     
     let request = UNNotificationRequest(identifier: "Test Indentifier", content: content, trigger: trigger)
     UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
}
