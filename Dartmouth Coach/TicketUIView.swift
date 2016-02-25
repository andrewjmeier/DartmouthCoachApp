//
//  TicketUIView.swift
//  Dartmouth Coach
//
//  Created by Jordan Kunzika on 2/24/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import Foundation
import UIKit

class TicketUIView : UITableViewCell {
    override func drawRect(rect: CGRect) {
        
        self.contentView.backgroundColor = UIColor.clearColor()
        
        let whiteRoundedView : UIView = UIView(frame: CGRectMake(5,0, self.contentView.frame.size.width-10, 130))
        
        whiteRoundedView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 0.33])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 30.0
        whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
        whiteRoundedView.layer.shadowOpacity = 0.8
        
        
        let slider = TicketUISlider.init(frame: self.contentView.frame)
        slider.addTarget(self, action: "sliderValueDidChanged:", forControlEvents: UIControlEvents.ValueChanged)
        slider.addTarget(self, action: "liftedFingerInside:", forControlEvents: UIControlEvents.TouchUpInside)
        slider.addTarget(self, action: "liftedFingerOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        
        slider.bounds = CGRectMake(0, -10, self.contentView.frame.width - 20, self.contentView.frame.height);
        slider.center = CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds))
        slider.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleTopMargin).union(UIViewAutoresizing.FlexibleBottomMargin)

        self.contentView.addSubview(slider)
        
        slider.setThumbImage(UIImage(named: "arrow")!, forState: .Normal)
        
        self.contentView.addSubview(whiteRoundedView)
        self.contentView.sendSubviewToBack(whiteRoundedView)

    }
}