//
//  ReceiptDetailsViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/15/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class ReceiptDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var model : Receipt?  // Receipts.sharedInstance.items[0]

    @IBOutlet weak var receiptDetailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveReceiptsDetails(_:)), name: .didReceiveReceiptsDetails, object : nil)
        
        receiptDetailTableView.delegate = self
        receiptDetailTableView.dataSource = self
        
        receiptDetailTableView.register(UINib(nibName: "ReceiptDetailHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiptDetailHead")
        
         receiptDetailTableView.register(UINib(nibName: "ReceiptDetailTailTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiptDetailTail")
        
        receiptDetailTableView.allowsSelection = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : model?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            let cell = receiptDetailTableView.dequeueReusableCell(withIdentifier: "ReceiptDetailHead", for: indexPath) as! ReceiptDetailHeadTableViewCell
            
            cell.companyName.text = model?.restuarant
          //  cell.companyLogo = model.items[indexPath.section]
            cell.dateReceived.text = model?.date
            
            var totalPrice  = 0.0
            var numberOfItems  = 0
            
            for item in model!.items!{
                totalPrice = totalPrice + Double(item.price)! * Double(item.quantity)!
                numberOfItems = numberOfItems + Int(item.quantity)!
            }
            
            
            
            cell.total_Items.text = "Total items: \(numberOfItems) | Total Price: $\(String(format: "%.2f", arguments: [totalPrice]) )"
            
            
            return cell
        } else {
            let cell = receiptDetailTableView.dequeueReusableCell(withIdentifier: "ReceiptDetailTail", for: indexPath) as! ReceiptDetailTailTableViewCell
            
            cell.quantityNPrice.text = "\(model!.items![indexPath.row].quantity) @ $\(model!.items![indexPath.row].price)"
            cell.total.text = String(format: "%.2f", arguments: [ Double(model!.items![indexPath.row].price)! *
                                                                 Double(model!.items![indexPath.row].quantity)!
                                                                ])
            
            cell.menuItem.text =  model!.items![indexPath.row].name
            
            return cell
            
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didReceiveReceiptsDetails(_ notification: Notification)
    {
        
        // restuarantLoadingIndicator.stopAnimating()
        //   s restuarantLoadingIndicator.isHidden = true
        receiptDetailTableView.reloadData()
    }
    
}
