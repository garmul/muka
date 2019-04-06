//
//  RestaurantListTableViewCell.swift
//  muka
//
//  Created by Gary Mullings on 9/18/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Cosmos
import MapKit

class RestaurantListTableViewCell: UITableViewCell {

  
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var restaurantLogo: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
   
    @IBOutlet weak var milesAway: UILabel!
    @IBOutlet weak var restaurantDescription: UITextView!
    @IBOutlet weak var restaurantRating: CosmosView!
    
    var lat : Double?
    var long : Double?
    
    
    @IBAction func navigateToLocation(_ sender: UIButton) {
        let regionDistance :    CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(lat!, long!)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: regionSpan.center),
                       MKLaunchOptionsMapSpanKey :   NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemake = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemake)
        
        mapItem.name = restaurantName.text
        mapItem.openInMaps(launchOptions: options)
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        restaurantName.sizeToFit()
        
        restaurantLogo.layer.cornerRadius = restaurantLogo.frame.size.width / 2
        restaurantLogo.clipsToBounds = true
       // restaurantLogo.layer.borderWidth = 1
        //restaurantLogo.layer.borderColor = UIColor.gray.cgColor
        
       
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(restaurantName : String, restaurantDescription : String, image : UIImage?, milesAway : String,
                    rating : Double, flag : String, lat: Double?, long : Double?)  {
        self.restaurantName.text = restaurantName.uppercased()
        self.restaurantDescription.text = restaurantDescription
        self.restaurantLogo?.image = image
        self.milesAway.text = "\(milesAway) miles away"
        self.restaurantRating.rating = rating
        self.flag.image = UIImage(named: flag + "-flag")
        self.lat = lat
        self.long = long
    }
    
}
