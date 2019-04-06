//
//  MessagesDetailViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class MessagesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    var model : Message?
    
    @IBOutlet weak var messageDetail: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageDetail.isScrollEnabled = false
        messageDetail.allowsSelection = false 
        messageDetail.delegate = self
        messageDetail.dataSource = self
        
        messageDetail.register(UINib(nibName: "MessageDetailHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "messageTableViewHead")
       
        messageDetail.register(UINib(nibName: "MessageDetailTailTableViewCell", bundle: nil), forCellReuseIdentifier: "messageTableViewTail")

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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewHead", for: indexPath) as! MessageDetailHeadTableViewCell
            
         //   cell.companyLogo.image = model?.companyLogo
            cell.companyName.text = model?.company.description
            cell.customer.text =  model?.customerEmail
            cell.date.text = model?.date
            cell.subject.text = model?.subject
            
            
            return cell
            
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewTail", for: indexPath) as! MessageDetailTailTableViewCell
            
            cell.contentDetails.text = model?.message
            
            return cell
            
        }
        
    
  
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if indexPath.section == 1 {
            return 600
            
        } else {
            return 100
        }
        
    }

//    messageTableViewHead
    
    
    
   

}
