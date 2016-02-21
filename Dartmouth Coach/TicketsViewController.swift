//
//  SecondViewController.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TicketTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TicketTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ticketcell")
        
//        let recognizer = UIPanGestureRecognizer(target: self, action: "didSwipe")
//        tableView.addGestureRecognizer(recognizer)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didSwipe(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Ended {
            let swipeLocation = recognizer.locationInView(self.tableView)
            if let swipedIndexPath = tableView.indexPathForRowAtPoint(swipeLocation) {
                if let swipedCell = self.tableView.cellForRowAtIndexPath(swipedIndexPath) as? TicketTableViewCell{
                    // Swipe happened. Do stuff!
                    swipedCell.handleSwipe(recognizer)
                }
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func activateTicket() {
        let alert = UIAlertController.showAlert("Ticket Activated", message: "Your ticket will expire in 90 minutes")
        presentViewController(alert, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TicketTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ticketcell") as! TicketTableViewCell
        cell.delegate = self
//        for var i = 0; i < cell.subviews.count; i++ {
//            let view:UIView = cell.subviews[i]
//            if(view.tag == 1) {
////                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
////                [tap setNumberOfTapsRequired:1];
////                [view addGestureRecognizer:tap];
//            }
//        }

        tableView.allowsSelection = false
        cell.setupGesture()
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 100.0
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false;
    }
//
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
    
    
    
}

