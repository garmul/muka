//
//  Message.swift
//  8_Love_Street_Restaurant
//
//  Created by Gary Mullings on 6/13/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
import UIKit
struct Message {
    let documentID : String
    let companyLogo : UIImage?
    let company : String
    let customerEmail : String
    let subject : String
    let date : String
    let message : String
    var viewed : String
    
    init(documentID : String, company : String , customerEmail : String , subject : String , date : String, message : String, viewed : String) {
        self.documentID = documentID
        self.company = company
        self.customerEmail = customerEmail
        self.subject = subject
        self.date = date
        self.message = message
        self.companyLogo = nil
        self.viewed = viewed
    }
    
}
