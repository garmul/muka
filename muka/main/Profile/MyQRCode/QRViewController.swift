//
//  QRViewController.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/11/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    
    let username = "gsmullings@gmail.com"

    @IBOutlet weak var QRCode: UIImageView!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = generateQRCode(from: username + "|\(Date())")
        QRCode.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    

}
