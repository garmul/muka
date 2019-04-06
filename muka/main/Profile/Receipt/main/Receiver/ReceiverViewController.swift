//
//  ReceiverViewController.swift
//  muka
//
//  Created by Gary Mullings on 2/19/19.
//  Copyright © 2019 Gary Mullings. All rights reserved.
//

import UIKit


protocol ReceiverCellDelegate  {
    func updateCellWithStatusInfo( cell : IndexPath, status : Bool)
    
}

class ReceiverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ReceiverCellDelegate {
   
    func updateCellWithStatusInfo(cell: IndexPath , status : Bool) {
        
        
        receiverStatus[cell.row] = status
        receiverTableview.reloadData()
        print("Data Added cell \(cell.row)" )
    }
    
  
    
    var selectedCell : IndexPath?

    let receiverList = ["Me","Scan","Signature"]
    var receiverStatus = [false,false,false]
    let receiverImages = [UIImage(named: "self18dp"),UIImage(named: "scan18dp"), UIImage(named: "signature18dp")]
    
    var viewableContainter : String = ""
   
    @IBOutlet weak var receiverTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiverTableview.delegate = self
        receiverTableview.dataSource = self
        
        receiverTableview.isScrollEnabled = false
        
        receiverTableview.register(UINib(nibName: "ReceiverTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "receiverTypes")

        
//        userImage.layer.cornerRadius = userImage.frame.size.width / 2
//        userImage.clipsToBounds = true
//        userImage.layer.borderWidth = 2
//        userImage.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return receiverList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiverTypes", for: indexPath) as! ReceiverTypeTableViewCell
       
        if receiverStatus[indexPath.row] == true {
            
            cell.ReceiverTypeSelected.text = "Set"
            
        }
        
        cell.receiverType.text = receiverList[indexPath.row]
        cell.receiverImage.image = receiverImages[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCell = indexPath
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showSelf", sender: nil)
            
            viewableContainter = receiverList[0]
            
        case 1:
            performSegue(withIdentifier: "scanReceiverQR", sender: nil)
        case 2:
            performSegue(withIdentifier: "showEntry", sender: nil)
            viewableContainter = receiverList[2]
        default:
            print("Nothing")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
     func bagButtonPressed(_ sender: UIButton_Badge) {
        let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bag")
        self.present(viewController, animated: true, completion: nil)
        
        
    }
    
    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if let selfVC = segue.destination as? SelfViewController {
            
            selfVC.delegate = self
            selfVC.indexPath = selectedCell
            
            
        }
        
        if let scanVC = segue.destination as? QRPersonalScannerController {
            
            scanVC.delegate = self
            scanVC.indexPath = selectedCell
            
            
        }
        
        
        if let signatureVC = segue.destination as? SignatureViewController {
            
            signatureVC.delegate = self
            signatureVC.indexPath = selectedCell
            
        }
        
    }
    

}
