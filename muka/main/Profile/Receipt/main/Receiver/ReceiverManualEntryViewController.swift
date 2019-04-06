//
//  ReceiverManualEntryViewController.swift
//  muka
//
//  Created by Gary Mullings on 3/1/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit

class ReceiverManualEntryViewController: UIViewController {

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
    self.dismiss(animated: true, completion: nil)
    }
}
