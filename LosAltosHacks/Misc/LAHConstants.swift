//
//  LAHConstants.swift
//  LosAltosHacks
//
//  Created by Dan Appel on 1/8/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit

struct LAHConstants {
    static let LAHStartDate = NSDate.specificDate(year: 2016, month: 1, day: 30, hour: 9)
    static let LAHEndDate = NSDate.specificDate(year: 2016, month: 1, day: 31, hour: 4)
    static let Saturday = NSDate.specificDate(year: 2016, month: 1, day: 30, hour: 0)
    static let Sunday = NSDate.specificDate(year: 2016, month: 1, day: 31, hour: 0)

    static let BaseAPIURLString = "https://s3-us-west-2.amazonaws.com/losaltoshacks/"
    static let SlackURL = NSURL(string: "slack://channel?id=C091PQ8NR&team=T091PGAAW")!
}

enum LAHColor {
    case DefaultColor
    case DefaultGreyColor
    case DefaultDarkGreyColor
    case Transparent
    
    case Logistics
    case Food
    case Workshop
    
    var value: UIColor {
        
        let c: UIColor
        switch self {
        case .DefaultColor:
            c = UIColor(red: 126.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .DefaultGreyColor:
            c = UIColor(white: 0.6, alpha: 1.0)
        case .DefaultDarkGreyColor:
            c = UIColor(white: 0.3, alpha: 1.0)
        case .Transparent:
            c = UIColor(white: 0, alpha: 0)
        case .Logistics:
            c = UIColor(red: 244/255, green: 208/255, blue: 63/255, alpha: 1.0)
        case .Food:
            c = UIColor(red: 246/255, green: 71/255, blue: 71/255, alpha: 1.0)
        case .Workshop:
            c = UIColor(red: 65/255, green: 131/255, blue: 215/255, alpha: 1.0)
            
        }
        
        return c
    }
}