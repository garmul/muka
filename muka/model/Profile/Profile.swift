//
//  Profile.swift
//  muka
//
//  Created by Gary Mullings on 10/29/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import Foundation
import UIKit
struct Profile {
    let userPicture : UIImage?
    let userFname : String
    let userLname : String

    
    init( userFname : String , userLname : String ) {
        self.userFname = userFname
        self.userLname = userLname
        self.userPicture = nil
    }
    
}
