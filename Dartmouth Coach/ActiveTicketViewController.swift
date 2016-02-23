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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        dateLabel.frame.origin = CGPoint(x: 100, y: 100)
        NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
    }
    
    func timerFired() {
//        dateLabel.frame.origin = CGPoint(x: dateLabel.frame.origin.x + 1, y: dateLabel.frame.origin.y + 1)
        dateLabel.frame.origin.x += 1
        dateLabel.frame.origin.y += 1
        print("fired!")
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
