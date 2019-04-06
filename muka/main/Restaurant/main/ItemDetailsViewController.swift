//
//  ItemDetailsViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/25/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import NotificationCenter

class ItemDetailsViewController: UIViewController {
    
    var bagItem : OrderType?
    var navbarTitle : String?

    
    @IBOutlet weak var bagButton: UIButton_Badge!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    var data : String?

    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
        navBar.topItem?.title = bagItem?.restaurant.name
        itemName.text = self.title
        stepper.value = 1.00
        quantity.text = String(Int(stepper.value))
        
        itemName.text = bagItem?.orderItems[0].name
        price.text = "$\(String(format : "%.2f", Float(bagItem!.orderItems[0].price)!) )"
            
        

        // Do any additional setup after loading the view.
    }
    


    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
    
        self.dismiss(animated: true, completion: nil)
        
       
    }
    
  
    @IBAction func bagButtonPressed(_ sender: UIButton_Badge) {
        let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bag")
        self.present(viewController, animated: true, completion: nil)
        
        
    }
    
  
    
    @IBAction func updateQuantityButtonPressed(_ sender: UIStepper) {
        quantity.text = String(Int(sender.value))
        total.text = "Total : $\(String( format : "%.2f" , Float(sender.value) * Float(bagItem!.orderItems[0].price)!) )"
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        total.text = "Total : $\(String(format: "%.2f", Float(stepper.value) * Float(bagItem!.orderItems[0].price)!) )"
        

        
        let mealBag = Bag.sharedInstance
        bagButton.badgeCount = mealBag.items?.orderItems.count ?? 0
    }
    
    @IBOutlet weak var buttonBadge: UIButton_Badge!
    
    @IBAction func addToBagButtonPressen(_ sender: UIButton) {
        
        let mealBag =   Bag.sharedInstance
        
        
        if  mealBag.items != nil  {
            
            if self.bagItem?.restaurant.name == mealBag.items?.restaurant.name {
                
                let mealItem = MealBaseType(picture: (self.bagItem?.orderItems[0].picture)!,
                                            description: (self.bagItem?.orderItems[0].description)!,
                                            name: (self.bagItem?.orderItems[0].name)!,
                                            grams:(self.bagItem?.orderItems[0].grams)!,
                                            price: (self.bagItem?.orderItems[0].price)!,
                                            mealType: "Lunch",
                                            sortOrder: 0,
                                            available: true,
                                            quantity: Int(quantity.text!)!)
                mealBag.addItem(orderType: bagItem!, mealBaseType: mealItem)
                
            } else {
                
                let alert = UIAlertController(title: "Reset Bag", message: "Reset Bag", preferredStyle: .actionSheet)
                let okButton = UIAlertAction(title: "Ok", style: .destructive) { (action) in
                    
                    mealBag.items?.orderItems.removeAll()
                    
                    let mealItem = MealBaseType(picture: (self.bagItem?.orderItems[0].picture)!,
                                                description: (self.bagItem?.orderItems[0].description)!,
                                                name: (self.bagItem?.orderItems[0].name)!,
                                                grams:(self.bagItem?.orderItems[0].grams)!,
                                                price: (self.bagItem?.orderItems[0].price)!,
                                                mealType: "Lunch",
                                                sortOrder: 0,
                                                available: true,
                                                quantity: Int(self.quantity.text!)!)
                
                    let item =  OrderType(status: "Processing", rating: "0", date: "Today", restaurant: self.bagItem!.restaurant, orderItems: [mealItem])
                    
                    Bag.sharedInstance.items = item
                    
                    NotificationCenter.default.post(name: Notification.Name("updateBagCount"), object: nil)
                }
                
                let cancelButton = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
                
                alert.addAction(okButton)
                alert.addAction(cancelButton)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
         else {

            let mealItem = MealBaseType(picture: (self.bagItem?.orderItems[0].picture)!,
                                        description: (self.bagItem?.orderItems[0].description)!,
                                        name: (self.bagItem?.orderItems[0].name)!,
                                        grams:(self.bagItem?.orderItems[0].grams)!,
                                        price: (self.bagItem?.orderItems[0].price)!,
                                        mealType: "Lunch",
                                        sortOrder: 0,
                                        available: true,
                                        quantity: Int(quantity.text!)!)

         let item =  OrderType(status: "Processing", rating: "0", date: "Today", restaurant: self.bagItem!.restaurant, orderItems: [mealItem])
            
            Bag.sharedInstance.items = item

        }

    NotificationCenter.default.post(name: Notification.Name("updateBagCount"), object: nil)
        
    
    }
    
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        
        let mealBag = Bag.sharedInstance
        bagButton.badgeCount = mealBag.items?.orderItems.count ?? 0
    }
    
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("updateBagCount")
    static let didReceiveMessages = Notification.Name("updateMessages")
    static let didReceiveReceipts = Notification.Name("updateReceipts")
    static let didReceiveReceiptsDetails = Notification.Name("updateReceiptsDetails")
    static let didReceiveUpdateMyProfile = Notification.Name("updateMyProfile")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
