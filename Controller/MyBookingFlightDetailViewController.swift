//
//  MyBookingFlightDetailViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/14/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class MyBookingFlightDetailViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseHandler.sharedInstance.downloadUserInfoInProfileViewController { (name, email, image) in
            DispatchQueue.main.async {
                self.name = name
                self.emailInfo = email
                self.upgradeDetail()
            }
        }
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
    }


}
