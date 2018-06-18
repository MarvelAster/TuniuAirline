//
//  FlightDetailViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/12/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree
class FlightDetailViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    var sourceAirport: Airport?
    var destAirport: Airport?
    var flights: [ScheduledFlights]?
    var departureTrip : String?
    var returnTrip : String?
    var backSourceAirport: String?
    var backDestAirport: String?
    var SourceAirportName: String?
    var DestAirportName: String?
    var backSourceAirportName: String?
    var backDestAirportName: String?
    var departureDurationTime: String?
    var returnDurationTime: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm Purchase", style:  .plain, target: self, action: #selector(doneBtnAction))
        backSourceAirport = destAirport?.city
        backDestAirport = sourceAirport?.city
        
        SourceAirportName = sourceAirport?.name
        DestAirportName = destAirport?.name
        backSourceAirportName = DestAirportName
        backDestAirportName = SourceAirportName
    }
    
    @IBAction func purchaseClick(_ sender: Any) {
        var str = self.price.text
        str?.removeFirst()
        print(str)
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: BraintreePayment.toKinizationKey, request: request)
        { [unowned self] (controller, result, error) in
            
            if let error = error {
                print(error.localizedDescription)
                
            } else if (result?.isCancelled == true) {
                print("Transaction Cancelled")
                
            } else if let nonce = result?.paymentMethod?.nonce, let amount = str {
                self.sendRequestPaymentToServer(nonce: nonce, amount: amount)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func purchaseSuccess() {
        if flights?.count == 1{
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights![0], departureTrip: toDate(time: flights![0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, completion: {()in
            })
        }else{
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights![0], departureTrip: toDate(time: flights![0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, completion: {()in
            })
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights![1], departureTrip: toDate(time: flights![1].departureTime), departureCity: backSourceAirport!, arriveCity: backDestAirport!, departureAirportName: backSourceAirportName!, arriveAirportName: backDestAirportName!, durationTime: returnDurationTime!, completion: {()in
            })
        }
    }
    
    @objc func doneBtnAction() {
        if flights?.count == 1{
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights![0], departureTrip: toDate(time: flights![0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, completion: {()in
            })
        }else{
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights![0], departureTrip: toDate(time: flights![0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, completion: {()in
            })
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights![1], departureTrip: toDate(time: flights![1].departureTime), departureCity: backSourceAirport!, arriveCity: backDestAirport!, departureAirportName: backSourceAirportName!, arriveAirportName: backDestAirportName!, durationTime: returnDurationTime!, completion: {()in
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flights == nil {
            return 0
        } else {
            return (flights?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "FlightDetialTableViewCell") as! FlightDetialTableViewCell
        if indexPath.row == 0{
            cell.airlineCompanyLabel.text = "\(flights![indexPath.row].carrierFsCode) Airline"
            cell.arriveCityLabel.text = "\(destAirport!.city!)(\(flights![indexPath.row].arrivalAirportFsCode))"
            cell.arriveTerminalLabel.text = flights![indexPath.row].arrivalTerminal
            cell.arriveTimeLabel.text = toTime(time: flights![indexPath.row].arrivalTime)
            cell.departureCityLabel.text = "\(sourceAirport!.city!)(\(flights![indexPath.row].departureAirportFsCode))"
            cell.departureTerminalLabel.text = flights![indexPath.row].departureTerminal
            cell.departureTimeLabel.text = toTime(time: flights![indexPath.row].departureTime)
            cell.flightNumberLabel.text = "flight number: \(flights![indexPath.row].flightNumber)"
            cell.durationTimeLabel.text = getTimeInterval(indexPath: indexPath)
            departureDurationTime = getTimeInterval(indexPath: indexPath)
            cell.dateLabel.text = toDate(time: flights![indexPath.row].departureTime)
            cell.stopsLabel.text = "\(flights![indexPath.row].stops)"
        }else{
            cell.airlineCompanyLabel.text = "\(flights![indexPath.row].carrierFsCode) Airline"
            cell.arriveCityLabel.text = "\(backDestAirport!)(\(flights![indexPath.row].departureAirportFsCode))"
            cell.arriveTerminalLabel.text = flights![indexPath.row].arrivalTerminal
            cell.arriveTimeLabel.text = toTime(time: flights![indexPath.row].arrivalTime)
            cell.departureCityLabel.text = "\(backSourceAirport!)(\(flights![indexPath.row].arrivalAirportFsCode))"
            cell.departureTerminalLabel.text = flights![indexPath.row].departureTerminal
            cell.departureTimeLabel.text = toTime(time: flights![indexPath.row].departureTime)
            cell.flightNumberLabel.text = "flight number: \(flights![indexPath.row].flightNumber)"
            cell.durationTimeLabel.text = getTimeInterval(indexPath: indexPath)
            returnDurationTime = getTimeInterval(indexPath: indexPath)
            cell.dateLabel.text = toDate(time: flights![indexPath.row].departureTime)
            cell.stopsLabel.text = "\(flights![indexPath.row].stops)"
        }
        return cell
    }
    
    
    func sendRequestPaymentToServer(nonce: String, amount: String) {
        let paymentURL = URL(string: "http://localhost:8000/checkout")!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(nonce)&amount=\(amount)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) -> Void in
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            
            guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let success = result?["success"] as? Bool, success == true else {
                print("Transaction failed. Please try again.")
                return
            }
            
            print("Successfully charged. Thanks So Much :)")
            self?.purchaseSuccess()
            }.resume()
    }
    
    func getTimeInterval(indexPath : IndexPath) -> String {
        let depatureTime = flights![indexPath.row].departureTime
        let arrivalTime = flights![indexPath.row].arrivalTime
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date1 = format.date(from: depatureTime)
        let date2 = format.date(from: arrivalTime)
        var inteval = Int((date2?.timeIntervalSince(date1!))!)
        let days = inteval/86400
        inteval = inteval - days * 86400
        let hours = inteval/3600
        inteval = inteval - hours * 3600
        let mins = inteval/60
        if days == 0 {
            return "\(hours)h \(mins)m"
        } else {
            return "\(days)d \(hours)h \(mins)m"
        }
    }
    
    func toTime(time : String) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = format.date(from: time)
        //print(date)
        format.dateFormat = "HH:mm"
        let date1 = format.string(from: date!)
        //print(date1)
        return date1
    }
    
    func toDate(time: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = format.date(from: time)
        //print(date)
        format.dateFormat = "MM-dd"
        let date1 = format.string(from: date!)
        //print(date1)
        return date1
    }
}
