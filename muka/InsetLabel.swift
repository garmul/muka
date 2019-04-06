//
//  InsetLabel.swift
//  muka
//
//  Created by Gary Mullings on 10/2/18.
//  Copyright © 2018 Gary Mullings. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)))
    }

}
