//
//  ReceiverContainerViewController.swift
//  muka
//
//  Created by Gary Mullings on 2/28/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class ReceiverContainerViewController: UIViewController {

 
    @IBOutlet weak var selfContainer: UIView!
    
    @IBOutlet weak var signatureContainer: UIView!
    
    var viewableContainer : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfContainer.isHidden = true
        signatureContainer.isHidden = true
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let theContainer = viewableContainer {
            
            if theContainer == "Self" {
                selfContainer.isHidden = false
                signatureContainer.isHidden = true
            } else {
                selfContainer.isHidden = true
                signatureContainer.isHidden = false
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
