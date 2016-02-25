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
    func displayInfoForTicket(ticket:TicketsViewController.TicketData);
}

class TicketTableViewCell: TicketUIView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var infoButton: UIImageView!
        
    var continuous:Bool = false
    
    func sliderValueDidChanged(sender: UISlider) {
        continuous = true
        if(sender.value == sender.maximumValue){
            if let del = self.delegate {
                sender.value = sender.minimumValue
                del.activateTicket(ticket!)
            }
        }
    }
    
    func liftedFingerInside(sender: UISlider) {
        if(continuous && sender.value < sender.maximumValue){
            sender.value = sender.minimumValue
        }
        continuous = false
    }

    func liftedFingerOutside(sender: UISlider) {
        if(continuous && sender.value < sender.maximumValue){
            sender.value = sender.minimumValue
        }
        continuous = false
    }
    
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
        userInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "displayTicketInfo:")
        
        self.addGestureRecognizer(tapGesture)
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
    
    func displayTicketInfo(recognizer: UITapGestureRecognizer){
        print("Recognized tap on cell!")
        let point = recognizer.locationInView(self.infoButton)
        print("Point: \(point.x), \(point.y); Info Button Origin: \(infoButton.frame.origin.x), \(infoButton.frame.origin.y); Info Button Size: \(infoButton.bounds.size)")
        let tappedInfoButton = infoButton.pointInside(point, withEvent: nil)
        if let del = self.delegate {
            
            if tappedInfoButton == true {
                print("Recognized tap on info button!")
                
                del.displayInfoForTicket(ticket!)
            }
        }
    }
    
    func handleSwipe(recognizer: UIPanGestureRecognizer) {
        print("Recognized swipe!")
    }
    
}
