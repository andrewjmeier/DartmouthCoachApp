//
//  UIAlertViewController+CS89.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/13/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        return alertController
    }
}
