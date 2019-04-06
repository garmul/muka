//
//  DrinksViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/26/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
   
    var drinks : [Drinks]?
    var restaurant : RestaurantDB?
    @IBOutlet weak var drinksTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinksTableView.delegate = self
        drinksTableView.dataSource = self
 
        drinksTableView.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "drinks")
        

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if let drinksscout = drinks?.count {
            return drinksscout
        } else
        {
            return 0
        }
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinks", for: indexPath) as! MenuItemTableViewCell
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        
        cell.layer.shadowOpacity = 0.40
        cell.layer.masksToBounds = false;
        cell.clipsToBounds = false;
        
        
        if let mealCellData =  self.drinks {
            
            cell.updateCell(itemDescription: mealCellData[indexPath.row].description  , price: mealCellData[indexPath.row].price, weight: mealCellData[indexPath.row].price, mealPicture: mealCellData[indexPath.row].picture, item: mealCellData[indexPath.row].name )
            
            
        }
        
        
        return cell
    }
    
    
    func refreshData()  {
        drinksTableView.reloadData()
    }
    
    
    
    


    

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(10)
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
        let mealItem = MealBaseType(picture: drinks![indexPath.row].picture,
                                    description: drinks![indexPath.row].description,
                                    name: drinks![indexPath.row].name,
                                    grams: "test grams",
                                    price: drinks![indexPath.row].price,
                                    mealType: "drinks",
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
            itemVC.navbarTitle = "Drinks"
            
            tableView.deselectRow(at: indexPath, animated: false)
            
            self.present(itemVC, animated: true, completion: nil)
        }
        
        
        
    }

}
