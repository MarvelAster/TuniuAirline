//
//  MyBookingFlightDetailViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/14/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import UserNotifications

class MyBookingFlightDetailViewController: UIViewController {

    @IBOutlet weak var seat: UILabel!
    @IBOutlet weak var confirmationNumberLabel: UILabel!
    @IBOutlet weak var bookingStatusLabel: UILabel!
    @IBOutlet weak var airportFScode: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var terminal: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var tripLabel: UILabel!
    @IBOutlet weak var personName: UILabel!
    
    var flights: BookedFlightsInfo?
    var name: String?
    var emailInfo: String?
    var date = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getHour(time: flights!.departureTime))
        print(getMinute(time: flights!.departureTime))
        print(getMonth(time:flights!.departureDate))
        print(getday(time:flights!.departureDate))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "alarmClock"), landscapeImagePhone: UIImage(named: "alarmClock"), style:  .plain, target: self, action: #selector(clockBtnAction))
        FirebaseHandler.sharedInstance.downloadUserInfoInProfileViewController { (name, email, image) in
            DispatchQueue.main.async {
                self.name = name
                self.emailInfo = email
                self.upgradeDetail()
            }
        }
    }
    
    @objc func clockBtnAction() {
        let alert = UIAlertController(title: "Set Notification", message: "Do you want to receive notification 2 hours before your flight taking off?", preferredStyle:  .alert)
        let okAction = UIAlertAction(title: "Yes please", style:  .default) { (okAction) in
            self.date.month = 06
            self.date.day = 20
            self.date.hour = 00
            self.date.minute = 23
            self.timeNotifications(date: self.date) { (flag) in
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style:  .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true)
    }
    
    func upgradeDetail(){
        confirmationNumberLabel.text = flights?.flightKey
        bookingStatusLabel.text = "Confirmed"
        airportFScode.text = "\(flights!.departureAirportFsCode) - \(flights!.arrivalAirportFsCode)"
        data.text = flights?.departureDate
        flightNumber.text = "Flight \(flights!.carrierFsCode) \(flights!.flightNumber)"
        time.text = "\(flights!.departureTime) - \(flights!.arrivalTime)"
        durationTime.text = flights!.durationTime
        terminal.text = "T\(flights!.departureTerminal)"
        tripLabel.text = "\(flights!.departureAirportName)-\(flights!.arriveAirportName)"
        personName.text = name
        email.text = emailInfo
        seat.text = flights?.seat
    }
    
    func timeNotifications(date: DateComponents, completion: @escaping (Bool)->Void) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Flight Reminder"
        content.body = "Your Flight will take off after 2 hours"
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil{
                completion(false)
            }else{
                completion(true)
            }
        }
    }
    
    func getHour(time : String) -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let date = format.date(from: time)
        format.dateFormat = "HH"
        let date1 = format.string(from: date!)
        return date1
    }
    
    func getMinute(time : String) -> String {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let date = format.date(from: time)
        format.dateFormat = "mm"
        let date1 = format.string(from: date!)
        return date1
    }
    
    func getday(time: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        let date = format.date(from: time)
        format.dateFormat = "dd"
        let date1 = format.string(from: date!)
        return date1
    }
    
    func getMonth(time: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        let date = format.date(from: time)
        format.dateFormat = "MM"
        let date1 = format.string(from: date!)
        return date1
    }
}
