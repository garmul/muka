    //
    //  ProfileViewController.swift
    //  8_Love_Street_Restaurant
    //
    //  Created by Gary Mullings on 5/26/18.
    //  Copyright © 2018 Gary Mullings. All rights reserved.
    //
    
    import UIKit
    
    class ProfileViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        
        let picker = UIImagePickerController()
        
        
        var profilePicture = UIImageView()
        {
            didSet{
                let indexPath = IndexPath(item: 0, section: 0)
                profileTableView.reloadData() //reloadRows(at: [indexPath], with: .automatic)
            }
           
        }
        
        struct ProfileStruct {
            let profileImage : UIImage
            let profileLabel : String
            
        }
        
        
        enum ProfileSection : Int {
            case head = 0
            case body
            case tail
        }
        
        let profileModel = ProfileModel()
        
        let profileTableViewData = [ProfileStruct(profileImage: UIImage(named: "mail")!, profileLabel: "Messages"),
                                    ProfileStruct(profileImage: UIImage(named: "settings")!, profileLabel: "Settings"),
                                    ProfileStruct(profileImage: UIImage(named: "piggy-bank")!, profileLabel: "Discounts"),
                                    ProfileStruct(profileImage: UIImage(named: "invoice")!, profileLabel: "Receipts"),
                                    ProfileStruct(profileImage: UIImage(named: "qr-code")!, profileLabel: "My QRCode"),
                                    ProfileStruct(profileImage: UIImage(named: "exitdp")!, profileLabel: "Logout")]
        
        @IBOutlet weak var profileTableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveUpdateMyProfile(_:)), name: .didReceiveUpdateMyProfile, object: nil)
            
            profileTableView.isScrollEnabled = false
            
            profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTail")
            
            profileTableView.register(UINib(nibName: "ProfileHeadCellTableViewCell", bundle: nil), forCellReuseIdentifier: "profileHead")
            
            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        
            var numberInSection = 0
            
            switch section {
            case 0 :
                numberInSection = 1
            case 1 :
                numberInSection =  profileTableViewData.count - 1
            case 2 :
               numberInSection = 1
            default:
                numberInSection = 0
            }
            
            return numberInSection
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            let profileSection =  ProfileSection(rawValue: indexPath.section)!
            
            
            switch profileSection {
           
            case .head :
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "profileHead", for: indexPath) as! ProfileHeadCellTableViewCell
                
                if let profile = profileModel.profile {
                    cell.fname.text = profile.userFname
                    cell.lname.text = profile.userLname
                    
                }
                
                 if profilePicture.image != nil {
                    
                    cell.UserPicture.image = profilePicture.image
                    
                }
                
                return cell
            case .body :
                
                let  cell = tableView.dequeueReusableCell(withIdentifier: "profileTail", for: indexPath) as! ProfileTableViewCell
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                
                cell.profileLineLabel.text  = profileTableViewData[indexPath.row].profileLabel
                
                cell.profileLineImage.image = profileTableViewData[indexPath.row].profileImage
                
          
                
                if indexPath.row == 0 {
                    
                    cell.counter.badgeCount = 1000
                    
                }
                
                return cell
            
            
            case .tail :
                
                let  cell = tableView.dequeueReusableCell(withIdentifier: "profileTail", for: indexPath) as! ProfileTableViewCell
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                
                cell.profileLineLabel.text  = profileTableViewData[5].profileLabel
                
                cell.profileLineImage.image = profileTableViewData[5].profileImage
                
                cell.profileLineLabel.textColor = UIColor.blue
              
                return cell
                
           
            }
           
       }
        
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
            return section == 0 ? CGFloat(0) : CGFloat(30)
            
        }
        
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            var chosenImage = UIImage()
            
           
            chosenImage =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            profilePicture.frame.size.height = 90
             profilePicture.frame.size.width = 90
            
            profilePicture.contentMode = .scaleToFill
            
            profilePicture = UIImageView(image: chosenImage)
            
             dismiss(animated: true, completion: nil)
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: false)
            
          switch indexPath.section  {
            case 0 :
             
                
                picker.delegate = self
                picker.sourceType = .camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                
                self.present(picker, animated: true, completion: nil)
                
                print("Change picture")
            case 1 :
                    switch indexPath.row {
                    case 0:
                        
                        performSegue(withIdentifier: "showMessages", sender: self)
                    case 1:
                        print(1)
                    case 2:
                        performSegue(withIdentifier: "showDiscounts", sender: self)
                    case 3:
                        performSegue(withIdentifier: "showReceipts", sender: self)
                    case 4:
                        performSegue(withIdentifier: "showQR", sender: self)
                    default:
                        print("d")
                    }
            case 2 :
                //TODO: do official log out
                 self.dismiss(animated: true, completion: nil)
            default:
                print("Default")
            }
            
            
        }
        
     @objc func didReceiveUpdateMyProfile(_ notification: Notification)
        {
            
            profileTableView.reloadData()
        }
        
    }
