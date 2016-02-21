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

class BusTimeView: UIView {
    
    @IBOutlet weak var depTime: UILabel!
    @IBOutlet weak var arrTime: UILabel!
    
    var delegate: BusTimeViewDelegate?

    func setupTimes(dep: String, arr: String) {
        depTime.text = dep
        arrTime.text = arr
        userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        addGestureRecognizer(gesture)
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        delegate?.timeClicked(self)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
