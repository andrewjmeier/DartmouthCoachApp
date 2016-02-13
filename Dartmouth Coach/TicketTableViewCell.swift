//
//  TicketTableViewCell.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

protocol TicketTableViewCellDelegate {
    func activateTicket();
}

class TicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
 
    var delegate: TicketTableViewCellDelegate?
    
    var imgStart: CGFloat = 12.0
    var imgEnd: CGFloat = 12.0
    
    func setupGesture() {
        userInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: "handleSwipe:")
        addGestureRecognizer(gesture)
        imgEnd = frame.width - 12 - imgView.frame.width - 90;
    }
    
    func handleSwipe(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.locationInView(self)
        if (recognizer.state == .Ended) {
            moveImage(imgStart)
        } else if (point.x < imgStart) {
            moveImage(imgStart)
        } else if (point.x > imgEnd) {
            moveImage(imgEnd)
            if let del = self.delegate {
                del.activateTicket()
            }
        } else {
            moveImage(point.x)
        }
    }
    
    func moveImage(location: CGFloat) {
        imgView.frame = CGRect(x: location, y: imgView.frame.origin.y, width: imgView.frame.width, height: imgView.frame.height)
    }
}
