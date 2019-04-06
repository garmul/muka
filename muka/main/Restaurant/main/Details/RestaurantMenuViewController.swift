//
//  RestuarantMenuViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/20/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import NotificationCenter
import FirebaseFirestore
import FirebaseStorage

class RestaurantMenuViewController: UIViewController {
    
    @IBOutlet weak var bagButton: UIButton_Badge!
    
    var restaurant : RestaurantDB?
    
    let db = Firestore.firestore()
    @IBOutlet weak var menuSegment: UISegmentedControl!
    
    @IBOutlet weak var foodContainer: UIView!
    @IBOutlet weak var drinksContainter: UIView!
    @IBOutlet weak var dessertContainer: UIView!
    
    @IBOutlet weak var restaurantNavBar: UINavigationBar!
    
    var restaurantMeals = [[MealBaseType]]()
    var mealLunch = [MealLunch]()
    var mealBreakfast = [MealBreakfast]()
    var mealEntree = [MealEntree]()
   
    var restaurantDrinks = [Drinks]()
    var restaurantDesserts = [Dessert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
   
        
        foodContainer.isHidden = false
        drinksContainter.isHidden = true
        dessertContainer.isHidden = true
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func menuSegmentButton(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            foodContainer.isHidden = false
            drinksContainter.isHidden = true
            dessertContainer.isHidden = true
            
            
            
            //  performSegue(withIdentifier: "meals", sender: nil)
            
        case 1:
            foodContainer.isHidden = true
            drinksContainter.isHidden = false
            dessertContainer.isHidden = true
        case 2:
            foodContainer.isHidden = true
            drinksContainter.isHidden = true
            dessertContainer.isHidden = false
            
        default:
            break
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if  segue.identifier == "meals" {
            
            
            let docRef =  db
                .collection("restaurant").document((restaurant?.name)!)
                .collection("meals")
            
            docRef.getDocuments() { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                   for document in querySnapshot!.documents {
                        
                        let data = document.data() as! Dictionary<String,String>
                        let picture = data["picture"]!
                        let description = data["description"]!
                        let name = data["name"]!
                        let grams = data["grams"]!
                        let price = data["price"]!
                        let mealType = data["mealType"]!
                        let available = Bool(data["available"]!)!
                    
                    
                    var sortOrder = 0
                
                    switch mealType {
                    case "Breakfast" :
                        sortOrder = 0
                    case "Lunch" :
                         sortOrder = 1
                    case "Entree" :
                         sortOrder = 2
                    default:
                         sortOrder = 0
                    }
                    
                    
                    switch mealType {
                    case "Lunch":
                        self.mealLunch.append(MealLunch(picture: picture, description: description, name: name, grams: grams, price: price, mealType : mealType, sortOrder : sortOrder, available : available, quantity: 0))
                    case "Breakfast":
                        self.mealBreakfast.append(MealBreakfast(picture: picture, description: description, name: name, grams: grams, price: price, mealType : mealType, sortOrder : sortOrder, available : available, quantity: 0))
                    case "Entree":
                        self.mealEntree.append(MealEntree(picture: picture, description: description, name: name, grams: grams, price: price, mealType : mealType, sortOrder : sortOrder, available : available, quantity: 0))
                    default :
                        self.mealLunch.append(MealLunch(picture: picture, description: description, name: name, grams: grams, price: price, mealType : mealType, sortOrder : sortOrder, available : available, quantity: 0))
                        
                        
                    }
                    
                    
    
                    
                    }
                    
                    
                    if self.mealLunch.count > 0 {
                        
                       self.restaurantMeals.append(self.mealLunch)
                    }
                    
                    if self.mealBreakfast.count > 0 {
                        
                        self.restaurantMeals.append(self.mealBreakfast)
                    }
                    
                    if self.mealEntree.count > 0 {
                        
                        self.restaurantMeals.append(self.mealEntree)
                    }
                    
                    
                 
                    
                    let view = segue.destination as? MealsViewController
                    
                    self.restaurantMeals = self.restaurantMeals.sorted(by: { $0[0].sortOrder < $1[0].sortOrder })
                    
                
                    view!.meals = self.restaurantMeals
                    
                    view!.restaurant =  self.restaurant!
                    
                    view!.refreshData() //[Meal(picture: "a", description: "b", name: "c", grams: "d"),
                    // Meal(picture: "w", description: "x", name: "y", grams: "z")]
                    
                    
                }
            }
            
        }
        
        
        if  segue.identifier == "drinks" {
            
            
            let docRef =  db
                .collection("restaurant").document((restaurant?.name)!)
                .collection("Drinks")
            
            docRef.getDocuments() { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in querySnapshot!.documents {
                        
                        let data = document.data() as! Dictionary<String,String>
                        let imagelocation = data["image"]!
                        let description = data["description"]!
                        let name = data["name"]!
                        let price = data["price"]!
                        
                        
                        self.restaurantDrinks.append(Drinks(picture: imagelocation, description: description, name: name, price: price))
                        
                        
                        print("\(document.documentID) => \(document.data())")
                        
                        
                    }
                    
                   let view = segue.destination as? DrinksViewController
                    view!.drinks = self.restaurantDrinks
                    view!.restaurant =  self.restaurant!
                    view!.refreshData() //[Meal(picture: "a", description: "b", name: "c", grams: "d"),
                    // Meal(picture: "w", description: "x", name: "y", grams: "z")]
                    
                    
                }
            }
            
            
            
            
        }
        
     
        if  segue.identifier == "dessert" {
            
            
            let docRef =  db
                .collection("restaurant").document((restaurant?.name)!)
                .collection("dessert")
            
            docRef.getDocuments() { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for document in querySnapshot!.documents {
                        
                        let data = document.data() as! Dictionary<String,String>
                        let picture = data["picture"]!
                        let description = data["description"]!
                        let name = data["name"]!
                    //    let grams = data["grams"]!
                        let price = data["price"]!
                        
                        self.restaurantDesserts.append(Dessert(picture: picture, description: description, name: name, price: price))
                        
                        print("\(document.documentID) => \(document.data())")
                        
                    }
                    
                    
                    let view = segue.destination as? DessertViewController
                    view!.dessert = self.restaurantDesserts
                    view!.restaurant =  self.restaurant!
                    view!.refreshData() //[Meal(picture: "a", description: "b", name: "c", grams: "d"),
                    // Meal(picture: "w", description: "x", name: "y", grams: "z")]
                    
                    
                }
            }
            
        }
        
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.restaurantNavBar.topItem?.title = restaurant?.name
        
        let mealBag = Bag.sharedInstance
        
        if let mealbag = mealBag.items {
         bagButton.badgeCount = mealbag.orderItems.count
        }
    }
    
    
    
    @IBAction func bagButtonPressed(_ sender: UIButton_Badge) {
        
        let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bag")
        self.present(viewController, animated: true, completion: nil)
    }
   
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        
        let mealBag = Bag.sharedInstance
        
        if let mealbag = mealBag.items {
            bagButton.badgeCount = mealbag.orderItems.count
        }
        
    }
    

    
    
}




