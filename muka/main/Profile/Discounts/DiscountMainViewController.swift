//
//  DiscountMainViewController.swift
//  muka
//
//  Created by Gary Mullings on 3/6/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class DiscountMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let model = DiscountModel()
    
    var selectedItem : IndexPath?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = model.items[indexPath.row].name
        cell.detailTextLabel?.text = model.items[indexPath.row].name
        
    
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedItem = indexPath
        
        performSegue(withIdentifier: "showDiscountHistory", sender: nil)
    }
  
    
    @IBOutlet weak var discountTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        discountTableView.dataSource = self
        discountTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let discountdetailVC = segue.destination as? DiscountViewController {
            discountdetailVC.selectItem = selectedItem
       
            
        }
    }
 
    
    
    @IBAction func backButtonPress(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func Reload(_ sender: UIBarButtonItem) {
       discountTableView.reloadData()
    }
    
}
