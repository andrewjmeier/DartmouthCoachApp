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

class TicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var infoButton: UIImageView!
    
    var slider: TicketUISlider!
    
    var continuous:Bool = false
    
    func sliderValueDidChanged(sender: UISlider) {
        continuous = true
        if(sender.value == sender.maximumValue){
            if let del = self.delegate {
                sender.removeFromSuperview()
                del.activateTicket(ticket!)
            }
        }
//        let currentValue = sender.value
//        label.text = "\(currentValue)"
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
    
//    override func drawRect(rect: CGRect) {
//        let c = UIGraphicsGetCurrentContext()
//        CGContextAddRect(c, CGRectMake(0, 0, 500, 300))
//        CGContextSetStrokeColorWithColor(c , UIColor.redColor().CGColor)
//        CGContextStrokePath(c)
//    }
 
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
        
        slider = TicketUISlider.init(frame: contentView.frame)
        slider.addTarget(self, action: "sliderValueDidChanged:", forControlEvents: UIControlEvents.ValueChanged)
        slider.addTarget(self, action: "liftedFingerInside:", forControlEvents: UIControlEvents.TouchUpInside)
        slider.addTarget(self, action: "liftedFingerOutside:", forControlEvents: UIControlEvents.TouchUpOutside)

        self.contentView.addSubview(slider)
        slider.bounds = CGRectMake(0, -35, contentView.frame.width - 10, contentView.frame.height);
        slider.center = CGPointMake(CGRectGetMidX(contentView.bounds), CGRectGetMidY(contentView.bounds))
        slider.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleTopMargin).union(UIViewAutoresizing.FlexibleBottomMargin)

//        let gesture = UIPanGestureRecognizer(target: self, action: "handleSwipe:")
//        gesture.delegate = self;
//        containerView.userInteractionEnabled = true
//        addGestureRecognizer(gesture)
        
        
        slider.setThumbImage(UIImage(named: "buy")!, forState: .Normal)
        
//        let superview = self.superview
//        
//        let shadowView = UIView(frame: CGRectMake(0, 0, self.contentView.frame.width, self.contentView.frame.height))
//        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
//        shadowView.layer.shadowOffset = CGSizeZero
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowRadius = 5
//        
//        let view = TicketUIView(frame: shadowView.bounds)
//        view.backgroundColor = UIColor.grayColor()
//        view.alpha = 0.25
//        view.layer.cornerRadius = 10.0
//        view.layer.borderColor = UIColor.grayColor().CGColor
//        view.layer.borderWidth = 0.5
//        view.clipsToBounds = true
//        
////        view.addSubview(self)
//        
//        shadowView.addSubview(view)
//        superview?.addSubview(shadowView)

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
//        let point = recognizer.locationInView(self)
//        if (recognizer.state == .Ended) {
//            moveImage(imgStart)
//        } else if (point.x < imgStart) {
//            moveImage(imgStart)
//        } else if (point.x > imgEnd) {
//            moveImage(imgEnd)
//            if let del = self.delegate {
//                del.activateTicket(ticket!)
//            }
//        } else {
//            moveImage(point.x)
//        }
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
//        imgView.frame = CGRect(x: location, y: imgView.frame.origin.y, width: imgView.frame.width, height: imgView.frame.height)
    }
}
