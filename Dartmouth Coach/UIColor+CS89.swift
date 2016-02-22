//
//  UIColor+CS89.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/22/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}