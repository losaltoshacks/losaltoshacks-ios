//
//  SlackButton.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 12/28/15.
//  Copyright © 2015 Dan Appel. All rights reserved.
//

import UIKit
import SnapKit

class SlackButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 20
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 1.0
    }
}
