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
    
    var velX:CGFloat = 1
    var velY:CGFloat = 1
    
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
                fileName = "patter3"
                break
            default:
                fileName = "pattern"
                break
        }
        let img = UIImage(named: fileName)
        patternView.image = img
        
                // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        dateLabel.frame.origin = CGPoint(x: 100, y: 100)
        NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
    }
    
    func timerFired() {
//        dateLabel.frame.origin = CGPoint(x: dateLabel.frame.origin.x + 1, y: dateLabel.frame.origin.y + 1)
        let pos = dateLabel.frame
        if (pos.origin.x + pos.size.width > patternView.frame.origin.x + patternView.frame.size.width) {
            velX = velX * -1
        } else if (pos.origin.x < patternView.frame.origin.x) {
            velX = velX * -1
        }
        
        if (pos.origin.y + pos.size.height > patternView.frame.origin.y + patternView.frame.size.height) {
            velY = velY * -1
        } else if (pos.origin.y < patternView.frame.origin.y) {
            velY = velY * -1
        }
        dateLabel.frame.origin.x += velX
        dateLabel.frame.origin.y += velY
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
