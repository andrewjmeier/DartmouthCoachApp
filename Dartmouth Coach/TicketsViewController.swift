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
    var prefs: NSUserDefaults!
    var tickets = [NSData]()
    let demo = true
    
    /*
        Data structure for tickets
    */
    final class TicketData: NSObject, NSCoding {
        
        var purchaseDate:NSDate?
        var origin:String?
        var destination:String?
        var departureTime:NSDate?
        var arrivalTime:NSDate?
        var activated:Bool = false
        var expirationDate:NSDate?
        
        func initWithInfo(origin: String, destination:String, departureTime:NSDate, arrivalTime: NSDate, activated:Bool, purchaseDate:NSDate){
            self.purchaseDate = purchaseDate
            self.origin = origin
            self.destination = destination
            self.departureTime = departureTime
            self.arrivalTime = arrivalTime
            self.activated = activated
        }
        
        required init(coder aDecoder: NSCoder) {
            purchaseDate = aDecoder.decodeObjectForKey("purchaseDate") as? NSDate
            origin = aDecoder.decodeObjectForKey("origin") as? String
            destination = aDecoder.decodeObjectForKey("destination") as? String
            departureTime = aDecoder.decodeObjectForKey("departureTime") as? NSDate
            arrivalTime = aDecoder.decodeObjectForKey("arrivalTime") as? NSDate
            activated = aDecoder.decodeObjectForKey("activated") as! Bool
            expirationDate = aDecoder.decodeObjectForKey("expirationDate") as? NSDate
        }
        
        override init() {
        }
        
        func encodeWithCoder(aCoder: NSCoder) {
            aCoder.encodeObject(purchaseDate, forKey: "purchaseDate")
            aCoder.encodeObject(origin, forKey: "origin")
            aCoder.encodeObject(destination, forKey: "destination")
            aCoder.encodeObject(departureTime, forKey: "departureTime")
            aCoder.encodeObject(arrivalTime, forKey: "arrivalTime")
            aCoder.encodeObject(activated, forKey: "activated")
            aCoder.encodeObject(expirationDate, forKey: "expirationDate")
        }

        func toNSData() -> NSData {
            return NSKeyedArchiver.archivedDataWithRootObject(self)
        }

        static func fromNSData(data:NSData) -> TicketData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! TicketData
        }
        
        func purchaseDateString() -> String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
            dateFormatter.timeStyle = .MediumStyle
            dateFormatter.dateFormat = "MM/dd/yy"
            
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateStyle = NSDateFormatterStyle.LongStyle
            timeFormatter.timeStyle = .MediumStyle
            timeFormatter.dateFormat = "h:mm:ss a"

            return "Purchased on " + dateFormatter.stringFromDate(self.purchaseDate!) + " at " + timeFormatter.stringFromDate(self.purchaseDate!)
        }
        
        func departureDateString() -> String {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            formatter.dateFormat = "h:mm:ss a"
            return "Departing from \(origin!) at " + formatter.stringFromDate(self.departureTime!)
        }
        
        func arrivalDateString() -> String {
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            formatter.dateFormat = "h:mm:ss a"
            return "Arriving to \(destination!) at " + formatter.stringFromDate(self.departureTime!)
        }
        
        func toString() -> String {            
            return purchaseDateString() + "\n\n" + departureDateString() + "\n\n" + arrivalDateString()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TicketTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ticketcell")
        
        
        prefs = NSUserDefaults.standardUserDefaults()
        
        /*
            Here, for the sake of demoing, we create 3 dummy tickets and add them to the user defaults.
            For now, tickets are only being added if there have never been tickets added to user defaults
            or if there are no remaining inactive tickets, so that if the user swipes all the tickets away,
            closes the app, and comes back, new dummy inactive tickets will be created. Once the flow for 
            creating the tickets themselves comes in place, we can disable that part by setting the demo bool to false
        */
        if(demo){
            let ticket1 = TicketData()
            let ticket2 = TicketData()
            let ticket3 = TicketData()
            
            ticket1.initWithInfo("Hanover", destination: "Logan Airport", departureTime: NSDate(), arrivalTime: NSDate(), activated: false, purchaseDate: NSDate())
            ticket2.initWithInfo("Logan Airport", destination: "Hanover", departureTime: NSDate(), arrivalTime: NSDate(), activated: false, purchaseDate: NSDate())
            ticket3.initWithInfo("Hanover", destination: "South Station", departureTime: NSDate(), arrivalTime: NSDate(), activated: false, purchaseDate: NSDate())
            
            
            tickets.append(ticket1.toNSData())
            tickets.append(ticket2.toNSData())
            tickets.append(ticket3.toNSData())
        }

        let oldTickets = prefs.arrayForKey("tickets") as? [NSData]
        var inactiveTickets = prefs.arrayForKey("inactiveTickets") as? [NSData]
        if(oldTickets != nil){
            if(demo){
                if(inactiveTickets?.count > 0){
                    tickets = oldTickets!
                }
            } else {
                tickets = oldTickets!
            }
        }
        
        prefs.setObject(tickets, forKey: "tickets")

        let activeTickets = tickets.filter({
            let t = TicketData.fromNSData($0)
            return t.activated == true
        })
        
        inactiveTickets = tickets.filter({
            let t = TicketData.fromNSData($0)
            return t.activated == false
        })

        prefs.setObject(inactiveTickets, forKey: "inactiveTickets")
        prefs.setObject(activeTickets, forKey: "activeTickets")
        
        prefs.synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func activateTicket(activatedTicket:TicketData) {
        let alert = UIAlertController.showAlert("Ticket Activated", message: "Your ticket will expire in 90 minutes")
        presentViewController(alert, animated: true, completion: {
            
            /*
                After the notification about the ticket activation, this modifies the ticket to activated, 
                refilters the arrays, saves them back to user defaults, and reloads the tableview.
            */
            
            var oldTickets = self.prefs.arrayForKey("tickets") as? [NSData]
            if(oldTickets != nil){
                for(var i = 0; i < oldTickets!.count; i++){
                    let currentTicket = TicketData.fromNSData(oldTickets![i])
                    if(currentTicket.purchaseDate!.isEqualToDate(activatedTicket.purchaseDate!)){
                        activatedTicket.setValue(true, forKey: "activated")
                        oldTickets!.removeAtIndex(i);
                        oldTickets!.append(activatedTicket.toNSData())
                        break
                    }
                }
                
                
                let activeTickets = oldTickets!.filter({
                    let t = TicketData.fromNSData($0)
                    return t.activated == true
                })
                let inactiveTickets = oldTickets!.filter({
                    
                    let t = TicketData.fromNSData($0)
                    return t.activated == false

                })

                self.prefs.setObject(inactiveTickets, forKey: "inactiveTickets")
                self.prefs.setObject(activeTickets, forKey: "activeTickets")
                
                
                self.prefs.setObject(oldTickets!, forKey: "tickets")
                
                self.prefs.synchronize(
                )
                
                self.tableView.reloadData()

            }
            
        })
    }
    
    func displayInfoForTicket(ticket:TicketData){
        let alert = UIAlertController.showAlert("Ticket Info", message: ticket.toString())
        presentViewController(alert, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inactiveTickets = prefs.arrayForKey("inactiveTickets") as? [NSData]
        if(inactiveTickets == nil){
            return 0
        } else {
            return inactiveTickets!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TicketTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ticketcell") as! TicketTableViewCell
        cell.delegate = self
        
        cell.slider?.removeFromSuperview();
        /*
            Getting inactive tickets from user defaults and loading them into the table view
        */
        
        let inactiveTickets = prefs.arrayForKey("inactiveTickets") as! [NSData]
        let currentTicket = TicketData.fromNSData(inactiveTickets[indexPath.row])
        
        cell.setupGesture(currentTicket)
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//
//    }
    
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

