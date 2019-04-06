//
//  ViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/18/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class LoginMain: UIViewController {


    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginCanvas: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    

    @IBOutlet weak var passwordTextField: UITextField!
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonShape(view: usernameTextField, borderWith: 1, borderColor: UIColor.blue.cgColor, clipsToBounds: true, cornerRadius: 20)
        configureButtonShape(view: passwordTextField, borderWith: 1, borderColor: UIColor.blue.cgColor, clipsToBounds: true, cornerRadius: 20)
        configureButtonShape(view: loginButton, borderWith: 1, borderColor: UIColor.white.cgColor, clipsToBounds: true, cornerRadius: 20)
        
        usernameTextField.text = "gsmullings@gmail.com"
        passwordTextField.text = "mullo111"
        
     
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let resetPasswordVC =  segue.destination as? ResetPasswordViewController{
            
           
        }
    }

    
    func configureButtonShape(view: UIView, borderWith : CGFloat, borderColor : CGColor, clipsToBounds : Bool, cornerRadius : CGFloat) {
        view.layer.borderWidth = borderWith
        view.layer.borderColor = borderColor
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = clipsToBounds
        
    }
    
    
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "resetPasswordSegue", sender: nil)
    
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
    
        sender.isEnabled = false
        
           Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
           
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                switch errCode {
                    case .userNotFound:
                       self.presentAlertMessage(message: "User does not exists")
                    case .wrongPassword:
                        self.presentAlertMessage(message: "Incorrect email or password")
                    case .emailAlreadyInUse:
                        self.presentAlertMessage(message: "Email Already in use")
                    case .invalidEmail:
                    self.presentAlertMessage(message: "Invalid Email")
                   default:
                        self.presentAlertMessage(message: String(errCode.hashValue))
                    }
                
                }
                
                
               
                print(error.debugDescription)
                
                
            }else {
                print("login Successful")
                
                sender.isEnabled = true
                self.performSegue(withIdentifier: "appMain", sender: nil)
                
            }
        }
        
     
        
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func presentAlertMessage(message : String) -> () {
        
        let alert = UIAlertController(title: "Error Message", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }


}

