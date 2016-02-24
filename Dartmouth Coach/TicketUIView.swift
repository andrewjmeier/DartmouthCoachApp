//
//  TicketUIView.swift
//  Dartmouth Coach
//
//  Created by Jordan Kunzika on 2/24/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import Foundation
import UIKit

class TicketUIView : UIView {
    override func drawRect(rect: CGRect) {
        let c = UIGraphicsGetCurrentContext()
        CGContextAddRect(c, CGRectMake(0, 0, 500, 300))
        CGContextSetStrokeColorWithColor(c , UIColor.redColor().CGColor)
        CGContextStrokePath(c)
    }
}