//
//  SignatureViewController.swift
//  muka
//
//  Created by Gary Mullings on 2/28/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {

    
    var delegate : ReceiverCellDelegate?
    var indexPath  : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        if delegate != nil && indexPath != nil {
            ScannedOrders.sharedInstance.hasReceiver = true
            delegate!.updateCellWithStatusInfo(cell : indexPath!, status: ScannedOrders.sharedInstance.hasReceiver )
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
}
