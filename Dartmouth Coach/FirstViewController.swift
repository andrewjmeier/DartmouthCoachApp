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
    
    
    var hasSelectedOrigin: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hasSelectedOrigin = false
        // Do any additional setup after loading the view, typically from a nib.
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func stepperValueChanged(sender: UIStepper) {
        
        numberOfTicketsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func originPressed(sender: UIButton) {
        hasSelectedOrigin = !sender.selected
        print(hasSelectedOrigin)
        changeOriginButtons(sender, state: sender.selected)
        sender.selected = !sender.selected
    }
    
    @IBAction func destPressed(sender: UIButton) {
        if (!hasSelectedOrigin) {
            showAlert("Oops", message: "Please select an origin first")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

