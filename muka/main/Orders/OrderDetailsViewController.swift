//
//  ReorderViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 5/24/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Cosmos

class OrderDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var ratingIndicator: CosmosView!
   
    @IBOutlet weak var total: UILabel!
    
    var order : OrderTable?
    
  //  var items : [MealBaseType]?

    @IBAction func cancel(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        var total : Double = 0.0
        
        for item in (order?.orderItems)! {
            
            total = total + Double(item.price!)! * Double(item.quantity)
            
            
        }
        
        self.total.text = "Total: $\(String(format: "%.2f", total))"
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationBar.topItem?.title = order?.restaurant?.name
        
        if let rating = order?.rating {
            if let rate = Double(rating) {
                ratingIndicator.rating = rate
            }
        }
        
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        
        ordersTableView.register(UINib(nibName: "OrderDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "orderDetails")

         // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return order?.orderItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    //    let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetails", for: indexPath) as! OrderDetailsTableViewCell

        cell.update(productName: order?.orderItems[indexPath.row].name ?? "No item",
                    productPrice: order?.orderItems[indexPath.row].price ?? "-1",
                    productQuantity: "Quantity : \(order!.orderItems[indexPath.row].quantity)")
        
//
//        cell.productName.text = items[indexPath.row]
//        cell.quantity.text = "\(order?.lunchItem[indexPath.row].quantity ?? 0)"

    //    cell.total.text = "\(Double(order?.orderItems[indexPath.row].price!)!  * Double(order?.orderItems[indexPath.row].price)!)"
        //Double(item.price!)! * Double(item.quantity)
        
        return cell
    }
    
  
    
    
    @IBAction func reload(_ sender: UIButton) {
   
    ordersTableView.reloadData()
    }
    
   
}
