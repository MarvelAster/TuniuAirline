//
//  MyBookingViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import UserNotifications

class MyBookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var durationTimeLabel: UILabel!
    
    var date = DateComponents()
    var flights = [BookedFlightsInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.weekday = 3
        date.hour = 14
        date.minute = 34
        timeNotifications(date: date) { (flag) in
            
        }
        FirebaseHandler.sharedInstance.downLoadMyBookingInfo { (flights) in
            self.flights = flights
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MyBookingTableViewCell") as! MyBookingTableViewCell
        cell.arriveCityFSCode.text = flights[indexPath.row].arrivalAirportFsCode
        cell.arriveTimeLabel.text = flights[indexPath.row].arrivalTime
        cell.dataLabel.text = flights[indexPath.row].departureDate
        cell.departureCityFSCode.text = flights[indexPath.row].departureAirportFsCode
        cell.departureTimeLabel.text = flights[indexPath.row].departureTime
        cell.flightNumberLabel.text = "\(flights[indexPath.row].carrierFsCode) \(flights[indexPath.row].flightNumber)"
        cell.tripLabel.text = "\(flights[indexPath.row].departureCity) - \(flights[indexPath.row].arriveCity)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MyBookingFlightDetailViewController") as! MyBookingFlightDetailViewController
        controller.flights = flights[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnClick(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
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
}
