//
//  BusTimeView.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/20/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

protocol BusTimeViewDelegate {
    func timeClicked(sender: BusTimeView);
}

@IBDesignable
class BusTimeView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
    @IBOutlet weak var depTime: UILabel!
    @IBOutlet weak var arrTime: UILabel!
    
    
    var schedule: BusSchedule?
    var delegate: BusTimeViewDelegate?

    func setupTimes(dep: String, arr: String) {
        depTime.text = dep
        arrTime.text = arr
    }
    
    func removeBorder() {
        layer.cornerRadius = 0
        layer.masksToBounds = false
        layer.borderWidth = 0
    }
    
    func tintBackground() {
        backgroundColor = tintColor
        print("clicked")
    }
    
    func untintBackground() {
        backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func tapCancel(sender: AnyObject) {
        untintBackground()
        depTime.textColor = UIColor.blackColor()
        arrTime.textColor = UIColor.blackColor()
        depTime.font = UIFont.systemFontOfSize(17.0)
        arrTime.font = UIFont.systemFontOfSize(17.0)
    }
    
    @IBAction func tapStart(sender: AnyObject) {
        if depTime.text != "Departure\nTime:" {
            tintBackground()
            depTime.textColor = UIColor.whiteColor()
            arrTime.textColor = UIColor.whiteColor()
            depTime.font = UIFont.boldSystemFontOfSize(17.0)
            arrTime.font = UIFont.boldSystemFontOfSize(17.0)
        }
    }
    
    @IBAction func handleTap(sender: AnyObject) {
        if depTime.text != "Departure\nTime:" {
            delegate?.timeClicked(self)
        }
    }
        

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
