//
//  TicketUISlider.swift
//  Dartmouth Coach
//
//  Created by Jordan Kunzika on 2/23/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import Foundation
import UIKit

class TicketUISlider:UISlider {

    override func trackRectForBounds(bounds: CGRect) -> CGRect {
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: CGPointMake(0, 40), size: CGSize(width: bounds.size.width, height: 15.0))
        super.trackRectForBounds(customBounds)
        return customBounds
    }

    
}