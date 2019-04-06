//
//  DiscountViewController.swift
//  muka
//
//  Created by Gary Mullings on 2/20/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var discountTableViewCell: UITableView!
    
    var model =  Discounts.sharedInstance
    
    var selectItem : IndexPath?
    
    var totalDiscount = 0
    
    @IBOutlet weak var netDiscount: UILabel!
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        
        discountTableViewCell.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        discountTableViewCell.delegate = self
        discountTableViewCell.dataSource = self
        
        discountTableViewCell.register(UINib(nibName: "DiscountableViewCell", bundle: nil), forCellReuseIdentifier: "discountCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
     
        
        //        for discount in model.items {
//
//            if  let discount = Int(discount.discount) {
//                totalDiscount = totalDiscount +  discount
//
//            }
//
//        }
//
//        netDiscount.text = String(totalDiscount)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items[selectItem!.row].discountLog.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "discountCell", for: indexPath) as! DiscountableViewCell
  //      cell.restaurantName.text = (model.items[indexPath.row].name).uppercased()
        cell.restaurantDate.text = model.items[0].discountLog[indexPath.row].date
        cell.restaurantDiscount.text = model.items[0].discountLog[indexPath.row].discount
//
//
//
//
//
//        if let discount  = Double(model.discounts[indexPath.row].discount) {
//            if discount > 0 {
//                cell.restaurantDiscount.textColor = UIColor.blue
//            } else {
//                 cell.restaurantDiscount.textColor = UIColor.red
//            }
//
//        }
//
        
       return cell
    }
    

    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
   
        dismiss(animated: true, completion: nil)
    
    }
    
}
