//
//  ScheduleViewController.swift
//  Dartmouth Coach
//
//  Created by Emma Oberstein on 2/22/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {

    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    @IBOutlet weak var cell6: UITableViewCell!
    @IBOutlet weak var cell7: UITableViewCell!
    
    var departure = ""
    var arrival = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.departure + " - " + self.arrival;
        cell1.textLabel!.text = "9:00am - 12:00pm"
        cell2.textLabel!.text = "11:00am - 1:00pm"
        cell3.textLabel!.text = "1:00pm - 4:00pm"
        cell4.textLabel!.text = "3:00pm - 6:00pm"
        cell5.textLabel!.text = "5:00pm - 9:00pm"
        cell6.textLabel!.text = "7:00pm - 10:00pm"
        cell7.textLabel!.text = "9:00pm - 12:00am"
        
        
        cell1.textLabel!.textAlignment = NSTextAlignment.Center
        cell2.textLabel!.textAlignment = NSTextAlignment.Center
        cell3.textLabel!.textAlignment = NSTextAlignment.Center
        cell4.textLabel!.textAlignment = NSTextAlignment.Center
        cell5.textLabel!.textAlignment = NSTextAlignment.Center
        cell6.textLabel!.textAlignment = NSTextAlignment.Center
        cell7.textLabel!.textAlignment = NSTextAlignment.Center
        
    
        cell1.textLabel!.font = UIFont.systemFontOfSize(35.0)
        cell2.textLabel!.font = UIFont.systemFontOfSize(35.0)
        cell3.textLabel!.font = UIFont.systemFontOfSize(35.0)
        cell4.textLabel!.font = UIFont.systemFontOfSize(35.0)
        cell5.textLabel!.font = UIFont.systemFontOfSize(35.0)
        cell6.textLabel!.font = UIFont.systemFontOfSize(35.0)
        cell7.textLabel!.font = UIFont.systemFontOfSize(35.0)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLocations(departure: String, arrival: String) {
        self.departure = departure
        self.arrival = arrival
        
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
