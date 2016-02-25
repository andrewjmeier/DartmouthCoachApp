//
//  ActiveTicketViewController.swift
//  Dartmouth Coach
//
//  Created by quinn on 2/15/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

class ActiveTicketViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var patternView: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var busTimeLabel: UILabel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var instructions: UILabel!
    
    var velX:CGFloat = 1
    var velY:CGFloat = 1
    
    var currentTicket: TicketsViewController.TicketData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY hh:mm"
        dateLabel.text = dateFormatter.stringFromDate(date)
        
        let random = arc4random_uniform(3)
        var fileName = ""
        switch (random) {
            case 0:
                fileName = "pattern"
                break
            case 1:
                fileName = "pattern2"
                break
            case 2:
                fileName = "pattern3"
                break
            default:
                fileName = "pattern"
                break
        }
        let img = UIImage(named: fileName)
        patternView.image = img
        
        
                // Do any additional setup after loading the view.
    }
    
    func hideAll() {
        locationLabel.hidden = true
        name.text = "You currently do not have an active ticket"
        timeRemainingLabel.hidden = true
        busTimeLabel.hidden = true
        patternView.hidden = true
        dateLabel.hidden = true
        instructions.hidden = true
    }
    
    func showAll() {
        locationLabel.hidden = false
        name.text = "John Smith"
        timeRemainingLabel.hidden = false
        busTimeLabel.hidden = false
        patternView.hidden = false
        dateLabel.hidden = false
        instructions.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let ticket = prefs.objectForKey("activeTicket") as? NSData
        if let tic = ticket {
            currentTicket = TicketsViewController.TicketData.fromNSData(tic)
            if ((currentTicket?.expirationDate?.timeIntervalSinceNow)! * -1 > 90) {
                currentTicket = nil
                prefs.setObject(nil, forKey: "activeTicket")
                prefs.synchronize()
                hideAll()
                return
            }
            showAll()
            print(currentTicket!.expirationDate?.timeIntervalSinceNow)
            locationLabel.text = "\(currentTicket!.origin!) to \(currentTicket!.destination!)"
            timeRemainingLabel.text = "Ticket expires in \(90 - Int((currentTicket!.expirationDate?.timeIntervalSinceNow)! * -1)) minutes"
            busTimeLabel.text = "\(currentTicket!.departureDateString())"
        } else {
            hideAll()
        }
        

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dateLabel.frame.origin = CGPoint(x: 100, y: 100)
        
        if (dateLabel.hidden == false) {
            NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
        }
        
    }
    
    func timerFired() {
        dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
            let pos = self.dateLabel.frame
            if (pos.origin.x + pos.size.width > self.patternView.frame.origin.x + self.patternView.frame.size.width) {
                self.velX = self.velX * -1
            } else if (pos.origin.x < self.patternView.frame.origin.x) {
                self.velX = self.velX * -1
            }
            
            if (pos.origin.y + pos.size.height > self.patternView.frame.origin.y + self.patternView.frame.size.height) {
                self.velY = self.velY * -1
            } else if (pos.origin.y < self.patternView.frame.origin.y) {
                self.velY = self.velY * -1
            }
            self.dateLabel.frame.origin.x += self.velX
            self.dateLabel.frame.origin.y += self.velY
        })
//        dateLabel.frame.origin = CGPoint(x: dateLabel.frame.origin.x + 1, y: dateLabel.frame.origin.y + 1)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
