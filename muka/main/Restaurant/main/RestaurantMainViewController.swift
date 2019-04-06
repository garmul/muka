//
//  RestaurantMainViewController.swift
//  muka
//
//  Created by Gary Mullings on 9/18/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import CoreLocation
import NotificationCenter
import RealmSwift


class RestaurantMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restuarantLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var restaurantTableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    var userLocation : CLLocation?
    
    var restaurant : RestaurantDB?
    
    let realmDB = try! Realm()
    
    var realModel : Results<RestaurantDB>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        realModel = realmDB.objects(RestaurantDB.self).sorted(byKeyPath: "name", ascending: true)
        
        
        searchBar.delegate = self
        searchBar.placeholder = "Enter Restaurant Name"
        
        
        restuarantLoadingIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        restuarantLoadingIndicator.startAnimating()
        
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        restaurantTableView.separatorColor = UIColor.clear
        restaurantTableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: "restaurantCell")
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didCompleteTask(_:)), name: .didCompleteTask, object: nil)
        
        
    }
    
    
    
    
    //   let gsReference = storage.reference(forURL: "gs://muka-5a505.appspot.com/JamrockDelights/s-l1600.jpg")
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realModel?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantListTableViewCell
        
        /////////////// location Calculations Begin
        
        var  resturantLocation = CLLocation()
        
        if let lat = self.realModel?[indexPath.row].lat,  let long = self.realModel?[indexPath.row].long {
            
            resturantLocation = CLLocation(latitude:  Double(lat)!,
                                           longitude: Double(long)!)
        }
        
        
        
        let userlocation = CLLocation(latitude: userLocation?.coordinate.latitude ?? 0, longitude: userLocation?.coordinate.longitude ?? 0)
        
        print(userLocation?.coordinate.latitude ?? 0,  userLocation?.coordinate.longitude  ?? 0)
        
        let distance : CLLocationDistance = userlocation.distance(from: resturantLocation)
        
        print("distance = \( round(distance/1609.34)) mil")
        
        
        let milesAway = "\(round(userlocation.distance(from: resturantLocation)/1609.34)) mil"
        
       
        
        ///////////// location Calculations End
        
        var rating : Double = 0.0
        
        if let rate =  self.realModel![indexPath.row].rating {
            
            if let myrate = Double(rate) {
                
                rating = myrate
                
            }
            
            
        }
        
        
        cell.updateCell(restaurantName: self.realModel?[indexPath.row].name ?? "",
                        restaurantDescription: self.realModel?[indexPath.row].desc ?? "",
                        image: UIImage(named: "jamaicaDinner3")!,
                        milesAway: milesAway,
                        rating: rating,
                        flag : self.realModel?[indexPath.row].flag ?? "",
                        lat: 0.00, //Double(self.realModel?[indexPath.row].lat),
            long: 0.00//  Double(self.realModel?[indexPath.row].long)
        )
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(175)
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        restaurant =  self.realModel?[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        performSegue(withIdentifier: "showMenuDetails", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let restuarantMenuVC = segue.destination as? RestaurantMenuViewController {
            
            restuarantMenuVC.restaurant = restaurant!
            
        }
        
        
        
    }
    
    
    @objc func didCompleteTask(_ notification: Notification)
    {
        
        restuarantLoadingIndicator.stopAnimating()
        restuarantLoadingIndicator.isHidden = true
        restaurantTableView.reloadData()
    }
    
    
    
}

extension RestaurantMainViewController : UISearchBarDelegate, CLLocationManagerDelegate  {
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        realModel = realModel?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        restaurantTableView.reloadData()
    
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        
        
        if searchBar.text?.count == 0 {
            
            searchBar.showsCancelButton = false
            
            realModel = realmDB.objects(RestaurantDB.self)
            restaurantTableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
        }
        
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted :
            print("restricted" )
        case .denied:
            print("denied" )
        case .notDetermined:
            print("notDetermined" )
            
        default:
            // location is allowed, start monitoring
            manager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations.last!
        
        if userLocation!.horizontalAccuracy > 0 {
            manager.stopUpdatingLocation()
            restaurantTableView.reloadData()
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            // Location updates are not authorized.
            manager.stopUpdatingLocation()
            return
        }
        print("Location ERROR")
    }
    
}
