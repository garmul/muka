//
//  CreateReceiptOrdersViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 8/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

protocol UpdateScannedOrders {
    func updateOrder()
}


class CreateReceiptOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateScannedOrders {
   
    
    @IBOutlet weak var scannedOrder: UITableView!
    
    func updateOrder() {
        scannedOrder.reloadData()
    }
    
     var model = ScannedOrders.sharedInstance
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : model.items.count
    }
    
    @IBOutlet weak var scanForOrders: UILabel!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "scannedHeadOrders", for: indexPath) as! ScannedObjectsHeadTableViewCell
            
   
            cell.totalItems.text = "\(model.items.count)"
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "scannedOrders", for: indexPath) as! ScannedObjectsTableViewCell
            
            cell.companyName.text = model.items[indexPath.row].restuarant.uppercased()
            cell.itemName.text = model.items[indexPath.row].dish
            cell.price.text = model.items[indexPath.row].price
            cell.customer.text = model.items[indexPath.row].customer
            
            return cell
        }
        
        
        
  }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        scannedOrder.register(UINib(nibName: "ScannedObjectsHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "scannedHeadOrders")
        
        scannedOrder.register(UINib(nibName: "ScannedObjectsTableViewCell", bundle: nil), forCellReuseIdentifier: "scannedOrders")
        
        scannedOrder.delegate = self
        scannedOrder.dataSource = self
        
        
       
    }
   
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
       
        if indexPath.section == 1 {
            
            let delete =  UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
                self.model.items.remove(at: indexPath.row)
                
                self.scannedOrder.deleteRows(at: [indexPath], with: .automatic)
                
                let headerIndexPath = IndexPath(row: 0, section: 0)
            
                self.scannedOrder.reloadRows(at: [headerIndexPath], with: .automatic)
                
                
            }
            
            return [delete]
            
        } else {
            return nil
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if model.items.count > 0 {
            scannedOrder.alpha = 1
            scanForOrders.alpha = 0
        } else  {
            scannedOrder.alpha = 0
            scanForOrders.alpha = 1
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            
            return CGFloat(65)
        } else  {
            
            return CGFloat(60)
        }
       
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let QRScannerVC = segue.destination as? QRScannerController {
            QRScannerVC.delegate = self
        }
        
        
        
    }
    
    
    
    @IBAction func scanButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showScanner", sender: nil)
        
    }
    

}
