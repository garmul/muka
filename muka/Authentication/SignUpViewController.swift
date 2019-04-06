//
//  SignUpViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/18/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonShape(button: googleButton, borderWith: 0, borderColor: UIColor.red.cgColor, clipsToBounds: true, cornerRadius: 20)
        configureButtonShape(button: facebookButton, borderWith: 0, borderColor: UIColor.blue.cgColor, clipsToBounds: true, cornerRadius: 20)
        configureButtonShape(button: signUpButton, borderWith: 1, borderColor: UIColor.white.cgColor, clipsToBounds: true, cornerRadius: 20)
       
        // Do any additional setup after loading the view.
    }
    


    
    func configureButtonShape(button: UIButton, borderWith : CGFloat, borderColor : CGColor, clipsToBounds : Bool, cornerRadius : CGFloat) {
        button.layer.borderWidth = borderWith
        button.layer.borderColor = borderColor
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = clipsToBounds
        
    }
    


}
