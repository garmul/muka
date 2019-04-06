//
//  MealsViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/20/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import ChameleonFramework

class MealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
  
    
    @IBOutlet weak var mealsTableview: UITableView!
    
    var meals : [[MealBaseType]]?
    //TODO : sort breakfast/lunch/entree
    
    var restaurant : RestaurantDB?
    
    let sectionHeadingImages = [UIImage(named: "breakfast"),UIImage(named: "lunch"),UIImage(named: "entree")]

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    mealsTableview.dataSource = self
    mealsTableview.delegate = self
    mealsTableview.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "meals")
        
        
       // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let noOfSection =  meals?.count  {
            return noOfSection
        } else  {
            return 0
        }
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let meal  =  meals  {
            return meal[section].count
        } else {
            return 0
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "meals", for: indexPath) as! MenuItemTableViewCell
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        
        cell.layer.shadowOpacity = 0.40
        cell.layer.masksToBounds = false;
        cell.clipsToBounds = false;
        
        
        
         if let mealCellData =  self.meals {
            
            
            if mealCellData[indexPath.section][indexPath.row].available == false {
                cell.disableControls()
                
            }
            
    
                        cell.updateCell( itemDescription: mealCellData[indexPath.section][indexPath.row].description ,
                                                   price: mealCellData[indexPath.section][indexPath.row].price,
                                                  weight: mealCellData[indexPath.section][indexPath.row].grams,
                                             mealPicture: mealCellData[indexPath.section][indexPath.row].picture,
                                                    item: mealCellData[indexPath.section][indexPath.row].name )
                    
                    
                }
      return cell
    
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var imageIndex = 0
        let  sectionText =  headingBasedOnMealType (mealBaseType : meals![section])
       
        
     
        switch sectionText {
        case "Breakfast" :
            imageIndex = 0
        case "Lunch" :
            imageIndex = 1
        case "Entree" :
            imageIndex = 2
        default:
            imageIndex = 0
        }
        
        let view = UIView()
       // view.backgroundColor = UIColor.flatSandDark
        
        let image = UIImageView(image: sectionHeadingImages[imageIndex])
        image.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text =  sectionText //headingBasedOnMealType (mealBaseType : meals![section])
        label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
        view.addSubview(label)
        
        
      
        
        return view
    }
    

    
    func headingBasedOnMealType( mealBaseType : [MealBaseType]) -> String {
        if mealBaseType is [MealLunch] {
            return "Lunch"
        } else if mealBaseType is [MealBreakfast] {
            return "Breakfast"
        } else {
            return "Entree"
            
        }
        
        
    }
    
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    
    func refreshData()  {
         mealsTableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if meals![indexPath.section][indexPath.row].available == true {
        
//        let bagItem = BagItem(picture: meals![indexPath.section][indexPath.row].picture,
//                          description: meals![indexPath.section][indexPath.row].description,
//                                 name: meals![indexPath.section][indexPath.row].name,
//                                price: meals![indexPath.section][indexPath.row].price,
//                                itemType: .meal,quantity : 1, restaurant : (restaurant?.name)!)
            
            let mealItem = MealBaseType(picture: meals![indexPath.section][indexPath.row].picture,
                                     description: meals![indexPath.section][indexPath.row].description,
                                     name: meals![indexPath.section][indexPath.row].name,
                                     grams: "test grams",
                                     price: meals![indexPath.section][indexPath.row].price,
                                     mealType: "Lunch",
                                     sortOrder: 0,
                                     available: true,
              
                                     
                                     quantity: 1)
            
            let orderRestaurant = OrderRestaurantDB()
            
            orderRestaurant.name = restaurant?.name
            orderRestaurant.desc = restaurant?.desc
            orderRestaurant.address = restaurant?.address
            orderRestaurant.flag = restaurant?.flag
            orderRestaurant.rating = restaurant?.rating
            orderRestaurant.lat = restaurant?.lat
            orderRestaurant.long = restaurant?.long
            orderRestaurant.image = restaurant?.image
            
            let bagItem = OrderType(status: "processing", rating: "0", date: "Today", restaurant: orderRestaurant, orderItems: [mealItem])
            
        let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "itemDetails")
        // Do any additional setup after loading the view, typically from a nib.
        if let itemVC = viewController as? ItemDetailsViewController {
           
            itemVC.bagItem = bagItem
            itemVC.navbarTitle = "Meals"
            
          
         
        self.present(itemVC, animated: true, completion: nil)
        }
        
        } else {
            print("Not Available")
            
        }
        
        
        
        
    }
    
   

}
