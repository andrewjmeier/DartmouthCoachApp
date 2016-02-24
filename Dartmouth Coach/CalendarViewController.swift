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
import PassKit

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
    var previousTicket: BusSchedule?
    var currentTicket: BusSchedule?
    var selectedDay: Int?
    var previousDay: Int?
    
    var possibleTimes = [Int: [BusSchedule]]()

    
    @IBOutlet weak var applePayButton: UIButton!
    
    var SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]

    
    let ApplePaySwagMerchantID = "merchant.com.cs89.monkeyinthemiddleapps" // Fill in your merchant ID here!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 9.2, *) {
            SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex, PKPaymentNetworkDiscover, PKPaymentNetworkChinaUnionPay]
        }
        title = "Select Your Departure Day"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = isArrival ? "Select Your Arrival Day" : "Select Your Departure Day"
        
        scrollView.removeAllSubviews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // setup scroll view for current day
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day], fromDate: date)
        let day = components.day
        setupPossibleTimes(day)
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
    
    func purchase() {
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.requiredShippingAddressFields = PKAddressField.Email
        
        var summaryItems = [PKPaymentSummaryItem]()
        summaryItems.append(PKPaymentSummaryItem(label: "Dartmouth Coach Ticket", amount: 56.00))
        
        summaryItems.append(PKPaymentSummaryItem(label: "Dartmouth Coach", amount: 56))
        
        request.paymentSummaryItems = summaryItems
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self
        self.presentViewController(applePayController, animated: true, completion: nil)
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
        
        buildSchedule()
    }
    
    func buildSchedule() {
        for i in 0...31 {
            var tempList:[BusSchedule] = []
            for (var i = 0; i < 8; i++) {
                let random = Double(arc4random_uniform(10))
                if (random > (5 + (Double(i) * 0.1))) {
                    tempList.append(scheduleList![i])
                }
            }
            possibleTimes[i] = tempList
        }
    }
    
    func setupPossibleTimes(day: Int) {
        
        let tempList = possibleTimes[day]
        
        scrollView.removeAllSubviews()
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
        
        if let list = tempList {
            for schedule:BusSchedule in list {
                let timeView: BusTimeView = (NSBundle.mainBundle().loadNibNamed("BusTimeView", owner: self, options: nil))[0] as! BusTimeView
                timeView.depTime.text = schedule.departTime
                timeView.arrTime.text = schedule.arrTime
                timeView.frame.origin = CGPoint(x: x, y: y)
                timeView.schedule = schedule
                scrollView.addSubview(timeView)
                timeView.delegate = self
                x += Int(timeView.frame.size.width) + 12
            }
            scrollView.contentSize = CGSize(width: x, height: Int(scrollView.frame.size.height))
        }
    }
}

extension CalendarViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: ((PKPaymentAuthorizationStatus) -> Void)) {
        completion(PKPaymentAuthorizationStatus.Success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true) { () -> Void in
            let alertController = UIAlertController(title: "Ticket Purchased", message:
                "Thanks for riding the Dartmouth Coach", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { [unowned self](action) -> Void in
                if let sch = self.previousTicket {
                    self.purcahseTicket(sch, day: self.previousDay!)
                } else {
                    print("NOT BUYING PREVIOUS TICKET")
                }
                if let sch = self.currentTicket {
                    self.purcahseTicket(sch, day: self.selectedDay!)
                } else {
                    print("NOT BUYING ticket")
                }
                
                self.navigationController?.popToRootViewControllerAnimated(true)
            }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

extension CalendarViewController: BusTimeViewDelegate {
    func timeClicked(sender: BusTimeView) {
        if (isArrival || isOneWay) {
            self.currentTicket = sender.schedule
            self.purchase()
            
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("calendar") as! CalendarViewController
            vc.setLocations(arrival!, arrival: departure!)
            vc.numTickets = numTickets
            vc.isArrival = true
            vc.previousTicket = sender.schedule
            vc.previousDay = selectedDay
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func purcahseTicket(schedule: BusSchedule, day: Int) {
        var tickets = NSUserDefaults.standardUserDefaults().arrayForKey("tickets") as? [NSData]
        if let list = tickets {
            print(list)
        } else {
            tickets = [NSData]()
        }
        let ticket1 = TicketsViewController.TicketData()
        
        let date = NSDate()
        
        let calendar = NSCalendar.currentCalendar()
        let comps = calendar.components([.Year, .Month, .Day, .Hour], fromDate: date)
        comps.hour = schedule.departureTime
        comps.day = day
        let newDate = calendar.dateFromComponents(comps)
        comps.hour = schedule.arrivalTime
        let arrDate = calendar.dateFromComponents(comps)
        
        ticket1.initWithInfo(schedule.departureLocation, destination: schedule.arrivalLocation, departureTime: newDate!, arrivalTime: arrDate!, activated: false, purchaseDate: NSDate())
        
        tickets!.append(ticket1.toNSData())
        
        NSUserDefaults.standardUserDefaults().setObject(tickets, forKey: "tickets")
        
        NSUserDefaults.standardUserDefaults().synchronize()
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
        
        selectedDay = dayView.date.day
        
        let date = CVDate(date: NSDate())
        
        if dayView.date.month > date.month || (dayView.date.day >= date.day && dayView.date.month == date.month) {
            setupPossibleTimes(dayView.date.day)
        } else {
            scrollView.removeAllSubviews()
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        
        let date = CVDate(date: NSDate())
        
        return dayView.date.month > date.month || (dayView.date.day >= date.day && dayView.date.month == date.month)
            
        
//        let day = dayView.date.day
//        let schedule = possibleTimes[day]
//        if schedule?.count > 0 {
//            return true
//        }
//        
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        let day = dayView.date.day
        let schedule = possibleTimes[day]
        var num = 0
        if let sch = schedule {
            num = sch.count
        }
        
        switch (num) {
        case _ where num < 1:
            let color = UIColor.colorFromRGB(0xFF2000)
            return [color]
        case _ where num < 3:
            let color = UIColor.colorFromRGB(0xFFC000)
            return [color]
        case _ where num < 5:
            let color = UIColor.colorFromRGB(0xD0FF00)
            return [color, color]
        case _ where num < 7:
            let color = UIColor.colorFromRGB(0x70FF00)
            return [color, color]
        default:
            let color = UIColor.colorFromRGB(0x10FF00)
            return [color, color, color]
            
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 15
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

