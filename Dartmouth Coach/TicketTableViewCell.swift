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
    @IBOutlet weak var containerView: UIView!
    
 
    var delegate: TicketTableViewCellDelegate?
    
    var imgStart: CGFloat = 12.0
    var imgEnd: CGFloat = 12.0
    
    func setupGesture() {
        userInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: "handleSwipe:")
        gesture.delegate = self;
//        containerView.userInteractionEnabled = true
        addGestureRecognizer(gesture)
        imgEnd = frame.width - 12 - imgView.frame.width - 90;
    }
    
    func handleSwipe(recognizer: UIPanGestureRecognizer) {
        print("Recognized swipe!")
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
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }

    
    func moveImage(location: CGFloat) {
        imgView.frame = CGRect(x: location, y: imgView.frame.origin.y, width: imgView.frame.width, height: imgView.frame.height)
    }
}
