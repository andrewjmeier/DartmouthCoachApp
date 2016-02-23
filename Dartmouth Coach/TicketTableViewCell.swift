//
//  TicketTableViewCell.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit


protocol TicketTableViewCellDelegate {
    func activateTicket(currentTicket:TicketsViewController.TicketData);
}

class TicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
 
    @IBOutlet weak var route: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var delegate: TicketTableViewCellDelegate?
    
    var imgStart: CGFloat = 12.0
    var imgEnd: CGFloat = 12.0
    
    var ticket:TicketsViewController.TicketData?
    
    func setupGesture(currentTicket:TicketsViewController.TicketData) {
        ticket = currentTicket
        setupTicket(ticket!)
//        userInteractionEnabled = true
        let gesture = UIPanGestureRecognizer(target: self, action: "handleSwipe:")
//        gesture.delegate = self;
//        containerView.userInteractionEnabled = true
        addGestureRecognizer(gesture)
        imgEnd = frame.width - 12 - imgView.frame.width - 90;
        resetSwipe()
    }
    
    func resetSwipe(){
        moveImage(imgStart)
    }
    
    func setupTicket(ticket:TicketsViewController.TicketData){
        setTicketRoute(ticket)
        setTicketDate(ticket)
        setTicketTime(ticket)
    }
    
    func setTicketRoute(ticket:TicketsViewController.TicketData){
        route.text = ticket.origin! + " -> " + ticket.destination!
    }
    
    func setTicketDate(ticket:TicketsViewController.TicketData){
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.stringFromDate(ticket.departureTime!)

        date.text = dateString
    }
    
    func setTicketTime(ticket:TicketsViewController.TicketData){
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        formatter.dateFormat = "hh:mm a"
        let dateString = formatter.stringFromDate(ticket.departureTime!)

        time.text = dateString

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
                del.activateTicket(ticket!)
            }
        } else {
            moveImage(point.x)
        }
    }
    
//    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//            let translation = panGestureRecognizer.translationInView(superview!)
//            if fabs(translation.x) > fabs(translation.y) {
//                return true
//            }
//            return false
//        }
//        return false
//    }

    
    func moveImage(location: CGFloat) {
        imgView.frame = CGRect(x: location, y: imgView.frame.origin.y, width: imgView.frame.width, height: imgView.frame.height)
    }
}
