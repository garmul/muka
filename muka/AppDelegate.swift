//
//  AppDelegate.swift
//  muka
//
//  Created by Gary Mullings on 9/18/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit
import Firebase
import Stripe
import Alamofire
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        do {
            
            let realmDB = try! Realm()
            
            try  realmDB.write {
                
                realmDB.deleteAll()
            }
            
            
        } catch {
            print("There was and error loading the database \(error)")
            
        }
        
        
        var _ = OrderModel()
        var _ = RestaurantModel() // load restaurants
        
         UITabBar.appearance().backgroundColor = UIColor.white
        
        createCustomerKey(withAPIVersion: "latest") { ( dictionary, error) in
            
            if error != nil {
                print(error.debugDescription)
            } else {
                
                for  (k,v) in dictionary! {
                    print("Key: \(k)")
                }
                
            }
        }
        
       // UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            print("\(granted)")
        }
        
       return true
    }

    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        // let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request("https://us-central1-muka-5a505.cloudfunctions.net/api1", method: .post, parameters: [
            "api_version": apiVersion
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

