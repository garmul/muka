//
//  stripetestViewController.swift
//  muka
//
//  Created by Gary Mullings on 10/4/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Alamofire
import Stripe

class stripetestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
       // let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request("https://us-central1-muka-5a505.cloudfunctions.net/api1", method: .post, parameters: [
            "api_version": apiVersion
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
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

}
