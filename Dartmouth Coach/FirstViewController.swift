//
//  FirstViewController.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var hanoverOriginButton: UIButton!
    @IBOutlet weak var newLondonOriginButton: UIButton!
    @IBOutlet weak var lebanonOriginButton: UIButton!
    @IBOutlet weak var southStationOriginButton: UIButton!
    @IBOutlet weak var loganOriginButton: UIButton!
    @IBOutlet weak var newYorkOriginButton: UIButton!
    
    @IBOutlet weak var hanoverDestinationButton: UIButton!
    @IBOutlet weak var lebanonDestinationButton: UIButton!
    @IBOutlet weak var newLondonDestinationButton: UIButton!
    @IBOutlet weak var southStationDestinationButton: UIButton!
    @IBOutlet weak var loganDestinationButton: UIButton!
    @IBOutlet weak var newYorkDestinationButton: UIButton!
    
    @IBOutlet weak var ticketTypeControl: UISegmentedControl!
    @IBOutlet weak var numberOfTicketsLabel: UILabel!
    @IBOutlet weak var numberOfTicketsStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func disableNHOriginButtons() {
        hanoverOriginButton.enabled = false;
        newLondonOriginButton.enabled = false;
        lebanonOriginButton.enabled = false;
    }
    
    func disableMassOriginButtons() {
        southStationOriginButton.enabled = false;
        loganOriginButton.enabled = false;
    }
    
    func disableNYOriginButtons() {
        newYorkOriginButton.enabled = false;
    }
    
    func disableNHDestButtons() {
        hanoverDestinationButton.enabled = false;
        lebanonDestinationButton.enabled = false;
        newLondonDestinationButton.enabled = false;
    }
    
    func disableMassDestButtons() {
        southStationDestinationButton.enabled = false;
        loganDestinationButton.enabled = false;
    }
    
    func disableNYDestButtons() {
        newYorkDestinationButton.enabled = false;
    }
    
    func disableOriginButtons(sender: UIButton) {
        disableNHOriginButtons()
        disableMassOriginButtons()
        disableNYOriginButtons()
        sender.enabled = true;
        
        switch (sender) {
        case hanoverOriginButton:
            disableNHDestButtons()
            break
        case lebanonOriginButton:
            disableNHDestButtons()
            break
        case newLondonOriginButton:
            disableNHDestButtons()
            break
        case southStationOriginButton:
            disableMassDestButtons()
            disableNYDestButtons()
            break
        case loganOriginButton:
            disableMassDestButtons()
            disableNYDestButtons()
            break
        case newYorkOriginButton:
            disableMassDestButtons()
            disableNYDestButtons()
            newLondonDestinationButton.enabled = false;
        default:
            break
        }
    }

    @IBAction func stepperValueChanged(sender: UIStepper) {
        
        numberOfTicketsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func nhOriginPressed(sender: UIButton) {
        if (sender.selected) {
            
        } else {
            disableOriginButtons(sender)
        }
        sender.selected = !sender.selected
    }
    
    @IBAction func bostonOriginPressed(sender: UIButton) {
        disableOriginButtons(sender)
    }
    @IBAction func newYorkOriginPressed(sender: UIButton) {
        disableOriginButtons(sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

