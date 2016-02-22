//
//  FirstViewController.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit

class BuyTicketsViewController: UIViewController {
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
    
    @IBOutlet weak var ticketNumPrompt: UILabel!
    
    var hasSelectedOrigin: Bool!
    
    var hideTopView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hasSelectedOrigin = false
        // Do any additional setup after loading the view, typically from a nib.
        
        if hideTopView {
            ticketTypeControl.hidden = true
            numberOfTicketsLabel.hidden = true
            numberOfTicketsStepper.hidden = true
        }
        
    }
    
    func changeNHOriginButtons(state: Bool) {
        hanoverOriginButton.enabled = state;
        newLondonOriginButton.enabled = state;
        lebanonOriginButton.enabled = state;
    }
    
    func changeMassOriginButtons(state: Bool) {
        southStationOriginButton.enabled = state;
        loganOriginButton.enabled = state;
    }
    
    func changeNYOriginButtons(state: Bool) {
        newYorkOriginButton.enabled = state;
    }
    
    func changeNHDestButtons(state: Bool) {
        hanoverDestinationButton.enabled = state;
        lebanonDestinationButton.enabled = state;
        newLondonDestinationButton.enabled = state;
    }
    
    func changeMassDestButtons(state: Bool) {
        southStationDestinationButton.enabled = state;
        loganDestinationButton.enabled = state;
    }
    
    func changeNYDestButtons(state: Bool) {
        newYorkDestinationButton.enabled = state;
    }
    
    func changeOriginButtons(sender: UIButton, state: Bool) {
        changeNHOriginButtons(state)
        changeMassOriginButtons(state)
        changeNYOriginButtons(state)
        sender.enabled = true;
        
        switch (sender) {
        case hanoverOriginButton:
            changeNHDestButtons(state)
            break
        case lebanonOriginButton:
            changeNHDestButtons(state)
            break
        case newLondonOriginButton:
            changeNHDestButtons(state)
            changeNYDestButtons(state)
            break
        case southStationOriginButton:
            changeMassDestButtons(state)
            changeNYDestButtons(state)
            break
        case loganOriginButton:
            changeMassDestButtons(state)
            changeNYDestButtons(state)
            break
        case newYorkOriginButton:
            changeMassDestButtons(state)
            changeNYDestButtons(state)
            newLondonDestinationButton.enabled = state;
        default:
            break
        }
    }
    
    func changeDestButtons(sender: UIButton, state: Bool) {
        changeNHDestButtons(state)
        changeMassDestButtons(state)
        changeNYDestButtons(state)
        sender.enabled = true
        
        switch (sender) {
        case hanoverDestinationButton:
            changeNHOriginButtons(state)
            break
        case lebanonDestinationButton:
            changeNHOriginButtons(state)
            break
        case newLondonDestinationButton:
            changeNHOriginButtons(state)
            changeNYOriginButtons(state)
            break
        case southStationDestinationButton:
            changeMassOriginButtons(state)
            changeNYOriginButtons(state)
            break
        case loganDestinationButton:
            changeMassOriginButtons(state)
            changeNYOriginButtons(state)
            break
        case newYorkDestinationButton:
            changeMassOriginButtons(state)
            changeNYOriginButtons(state)
            newLondonOriginButton.enabled = state;
        default:
            break
        }
    }

    @IBAction func stepperValueChanged(sender: UIStepper) {
        
        numberOfTicketsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func originPressed(sender: UIButton) {
        origin = sender.currentTitle
        hasSelectedOrigin = !sender.selected
        print(hasSelectedOrigin)
        changeOriginButtons(sender, state: sender.selected)
        sender.selected = !sender.selected
    }
    
    @IBAction func destPressed(sender: UIButton) {
        destination = sender.currentTitle
        if (hasSelectedOrigin == true) {
            // transition to next screen?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("calendar") as! CalendarViewController
            vc.numTickets = Int(numberOfTicketsStepper.value)
            vc.isOneWay = ticketTypeControl.selectedSegmentIndex == 0
            vc.setLocations(origin!, arrival: destination!)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            changeDestButtons(sender, state: sender.selected)
            sender.selected = !sender.selected
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

