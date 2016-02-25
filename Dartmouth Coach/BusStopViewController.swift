//
//  BusStopViewController.swift
//  Dartmouth Coach
//
//  Created by Emma Oberstein on 2/15/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit
import MapKit

class BusStopViewController: UIViewController {

    @IBOutlet weak var titleLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stopTitle: UILabel!
    @IBOutlet weak var stopAddress: UILabel!
    
    @IBOutlet weak var stopInfo: UITextView!
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var lat:Double = 0;
        var long:Double = 0;
        
        if let stopType = type {
            switch (stopType) {
                case "Hanover":
                    stopTitle.text = "Hanover Stop Location"
                    stopAddress.text = "Hanover Inn, Wheelock Street, Hanover, NH 03755"
                    stopInfo.text = "The Hanover Stop is on East Wheelock Street directly in front of the Hopkins Center."
                    lat = 43.70241
                    long = -72.28824
                    break
                case "Lebanon":
                    stopTitle.text = "Lebanon Stop Location"
                    stopAddress.text = "Dartmouth Regional Transportation Terminal, Lebanon, NH 03766"
                    stopInfo.text = "The Lebanon Stop is on Etna Road at the Dartmouth Regional Transportation Terminal."
                    lat = 43.663948
                    long = -72.241726
                    break
                case "New London":
                    stopTitle.text = "New London Stop Location"
                    stopAddress.text = "NH Park & Ride, New London, NH 03257"
                    stopInfo.text = "The New London Stop is off of Exit 12 on the I-89 Highway ath the New Hampshire Park & Ride"
                    lat =  43.421613
                    long = -72.038659
                    break
                case "South Station":
                    stopTitle.text = "South Station Stop Location"
                    stopAddress.text = "South Station Bus Terminal, Gate 17"
                    stopInfo.text = "The South Station stop is located at gates 14-17 of the South Station bus terminal."
                    lat =  42.350448
                    long = -71.055718
                    break
                case "Logan Airport":
                    titleLabelHeight.constant = 0
                    stopTitle.text = "Logan Stop Location"
                    stopAddress.text = ""
                    stopInfo.text = "Terminal A: Downstairs, outside of baggage claim, all the way down to the right of the terminal near the signs that read Scheduled Buses." + "\r\n" + "Terminal B: Downstairs outside of baggage claim by the orange bus sign at US Airways and American Airlines. Reminder, after the bus departs from Terminal A, it will proceed to B1, and then B2. Dartmouth Coach only picks up at the far right handside of the terminal as you exit the facility. An orange bus sign is located to the left." + "\r\n" + "Terminal C: Outside of baggage claim, wait by the curb, by the scheduled orange bus sign." + "\r\n" + "Terminal E: Downstairs, outside of baggage claim, all the way down to the right of the terminal, by the scheduled orange bus sign."
                    lat =  42.367540
                    long = -71.017959
                case "New York City":
                    stopTitle.text = "New York City Stop Location"
                    stopAddress.text = "150 East 42nd Street, New York, NY 10017"
                    stopInfo.text = "The New York City Stop is located at 150 East 42nd Street (between Lexington and 3rd Avenue) in front of the Wells Fargo building."
                    lat =  40.751168
                    long = -73.975438
                    break
                default:
                    break
                
                
            }
        }

        
        // display a map centered at the Hanover stop and show a pin there
        let latDelta:CLLocationDegrees = 0.005
        let longDelta:CLLocationDegrees = 0.005
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
        mapView.setRegion(region, animated: true)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        self.mapView.addAnnotation(objectAnnotation)
        
        
        
        
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
    
    let regionRadius: CLLocationDistance = 250
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    

}
