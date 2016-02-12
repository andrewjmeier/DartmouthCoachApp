//
//  SecondViewController.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TicketTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ticketcell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TicketTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ticketcell") as! TicketTableViewCell
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 100.0
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

