//
//  MessagesMainViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MessagesMainViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var messagesTableView: UITableView!
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedMessage : IndexPath?
 
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

    var model = MessageModel()

  
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMessages(_:)), name: .didReceiveMessages, object: nil)
        
        
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(UINib(nibName: "MessageMainTableViewCell", bundle: nil), forCellReuseIdentifier: "messagesMain")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesMain", for: indexPath) as! MessageMainTableViewCell
        
   //     cell.companyLogo.image = model[indexPath.row].comp
        cell.subject.text = model.messages[indexPath.row].subject
        cell.message.text = model.messages[indexPath.row].message
        cell.messageDate.text = model.messages[indexPath.row].date
        cell.customer.text = (model.messages[indexPath.row].company).uppercased()
        
        if model.messages[indexPath.row].viewed == "0" {
            cell.customer.font = UIFont.boldSystemFont(ofSize: 13)
            cell.subject.font = UIFont.boldSystemFont(ofSize: 13)
            
        } else {
            cell.customer.font = UIFont.init(name: "Arial", size: 13)
            cell.subject.font = UIFont.init(name: "Arial", size: 13)
        }
        
        
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     //   messagesTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMessage = indexPath
        
        
        model.messages[indexPath.row].viewed = "1"
    
        performSegue(withIdentifier: "showMessageDetails", sender: nil)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let MessageDetailVC = segue.destination as? MessagesDetailViewController {
            if let indexPath = selectedMessage {
                MessageDetailVC.model = self.model.messages[indexPath.row]
            }
        }
        
    }
   
    
    @objc func didReceiveMessages(_ notification: Notification)
    {
        
       // restuarantLoadingIndicator.stopAnimating()
       //   s restuarantLoadingIndicator.isHidden = true
        messagesTableView.reloadData()
    }
    
    
    
    @IBAction func showSearchBar(_ sender: UIBarButtonItem) {
        
        if (searchBar.isHidden) {
             searchBar.isHidden = false
         
            UIView.animate(withDuration: 0.5) {
              //  self.searchBar.alpha = 1
                self.searchBar.frame.size = CGSize(width:  self.searchBar.frame.width, height: 50)
            }
            
        } else  {
         
            searchBar.isHidden = true
            
            UIView.animate(withDuration: 0.5) {
             //   self.searchBar.alpha = 0
                self.searchBar.frame.size = CGSize(width:  self.searchBar.frame.width, height: 0)
            }
        }
    
       
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "delete") { (action, indexPath) in
  
         
             let db = Firestore.firestore()

            db.collection("profile").document("gsmullings@gmail.com")
                .collection("messages").document(self.model.messages[indexPath.row].documentID).delete() { err in
                    if let err = err {
                        print("Error removing Document : \(err)")
                    } else {
                        
                        self.model.messages.remove(at: indexPath.row)
                        
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        print("Document Removed Successfully!")
                    }
            }
            
 
            }
         
        
        
        
        return [delete]
        
        
    }
    
}
