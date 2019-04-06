//
//  DessertViewController.swift
//  muka
//
//  Created by Gary Mullings on 10/2/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class DessertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dessert : [Dessert]?
    var restaurant : RestaurantDB?
    
    @IBOutlet weak var dessertTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dessertTableView.delegate = self
        dessertTableView.dataSource = self
        
        dessertTableView.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "dessert")
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dessertscout = dessert?.count {
            return dessertscout
        } else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dessert", for: indexPath) as! MenuItemTableViewCell
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        
        cell.layer.shadowOpacity = 0.40
        cell.layer.masksToBounds = false;
        cell.clipsToBounds = false;
        
        
        if let mealCellData =  self.dessert {
            
            cell.updateCell(itemDescription: mealCellData[indexPath.row].description  , price: mealCellData[indexPath.row].price, weight: mealCellData[indexPath.row].price, mealPicture: mealCellData[indexPath.row].picture, item: mealCellData[indexPath.row].name )
            
            
        }
        
        
        return cell
    }
    
    
    func refreshData()  {
        dessertTableView.reloadData()
    }
    
    
      func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        
        let mealItem = MealBaseType(picture: dessert![indexPath.row].picture,
                                    description: dessert![indexPath.row].description,
                                    name: dessert![indexPath.row].name,
                                    grams: "test grams",
                                    price: dessert![indexPath.row].price,
                                    mealType: "Dessert",
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
            itemVC.navbarTitle = "Dessert"
            
            tableView.deselectRow(at: indexPath, animated: false)
            
            self.present(itemVC, animated: true, completion: nil)
        }
        
        
        
    }
    
    

}
