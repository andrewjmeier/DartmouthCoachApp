//
//  CalendarViewController.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

//
//  FirstViewController.swift
//  Dartmouth Coach
//
//  Created by Andrew Meier on 2/12/16.
//  Copyright © 2016 CS89. All rights reserved.
//

import UIKit
import CVCalendar

struct BusSchedule {
    var departureLocation = "Hanover"
    var departureTime:Int = 0;
    var departTime: String {
        get {
            if (departureTime < 12) {
                return "\(departureTime):00 am"
            } else if (departureTime == 12) {
                return "\(departureTime):00 pm"
            } else {
                return "\(departureTime - 12):00 pm"
            }
        }
    }
    var arrivalLocation = "Logan Airport"
    var arrivalTime:Int = 0;
    var arrTime: String {
        get {
            if (arrivalTime < 12) {
                return "\(arrivalTime):00 am"
            } else if (arrivalTime == 12) {
                return "\(arrivalTime):00 pm"
            } else {
                return "\(arrivalTime - 12):00 pm"
            }
        }
    }
}

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var scheduleList:[BusSchedule]?
    var departure: String?
    var arrival: String?
    var isArrival = false
    var isOneWay = false
    var numTickets = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        title = isArrival ? "Select Your Arrival Day" : "Select Your Departure Day"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLocations(departure: String, arrival: String) {
        self.departure = departure
        self.arrival = arrival
        
        let first = BusSchedule(departureLocation: departure, departureTime: 7, arrivalLocation: arrival, arrivalTime: 10)
        let second = BusSchedule(departureLocation: departure, departureTime: 9, arrivalLocation: arrival, arrivalTime: 12)
        let third = BusSchedule(departureLocation: departure, departureTime: 11, arrivalLocation: arrival, arrivalTime: 14)
        let fourth = BusSchedule(departureLocation: departure, departureTime: 13, arrivalLocation: arrival, arrivalTime: 16)
        let fifth = BusSchedule(departureLocation: departure, departureTime: 15, arrivalLocation: arrival, arrivalTime: 18)
        let sixth = BusSchedule(departureLocation: departure, departureTime: 17, arrivalLocation: arrival, arrivalTime: 20)
        let seventh = BusSchedule(departureLocation: departure, departureTime: 19, arrivalLocation: arrival, arrivalTime: 22)
        let eigth = BusSchedule(departureLocation: departure, departureTime: 21, arrivalLocation: arrival, arrivalTime: 24)
        scheduleList = [first, second, third, fourth, fifth, sixth, seventh, eigth]
    }
    
    func setupPossibleTimes() {
        
        scrollView.removeAllSubviews()
        
        var tempList:[BusSchedule] = []
        for (var i = 0; i < 8; i++) {
            let random = Double(arc4random_uniform(10))
            if (random > 1) {
                tempList.append(scheduleList![i])
            }
        }
        
        print(tempList)
        var x = 0;
        let y = 0;
        
        let timeView: BusTimeView = (NSBundle.mainBundle().loadNibNamed("BusTimeView", owner: self, options: nil))[0] as! BusTimeView
        timeView.depTime.text = "Departure\nTime:"
        timeView.arrTime.text = "Arrival\nTime:"
        timeView.frame.origin = CGPoint(x: x, y: y)
        timeView.removeBorder()
        timeView.delegate = self
        scrollView.addSubview(timeView)
        x += Int(timeView.frame.size.width) + 12
        
        
        for schedule:BusSchedule in tempList {
            let timeView: BusTimeView = (NSBundle.mainBundle().loadNibNamed("BusTimeView", owner: self, options: nil))[0] as! BusTimeView
            timeView.depTime.text = schedule.departTime
            timeView.arrTime.text = schedule.arrTime
            timeView.frame.origin = CGPoint(x: x, y: y)
            scrollView.addSubview(timeView)
            timeView.delegate = self
            x += Int(timeView.frame.size.width) + 12
        }
        scrollView.contentSize = CGSize(width: x, height: Int(scrollView.frame.size.height))

    }
}

extension CalendarViewController: BusTimeViewDelegate {
    func timeClicked(sender: BusTimeView) {
        if (isArrival || isOneWay) {
            let controller = UIAlertController.showAlert("Buy", message: "Purchse your ticket using Apple Pay!")
            presentViewController(controller, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("calendar") as! CalendarViewController
            vc.setLocations(departure!, arrival: arrival!)
            vc.numTickets = numTickets
            vc.isArrival = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
        
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
        setupPossibleTimes()
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRectMake(0, 0, $0.width, $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
}

extension CalendarViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

