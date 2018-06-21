//
//  BookingConfirmViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/18/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree
import SVProgressHUD

class BookingConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, BookingConfirmTableViewCell1Delegate, BookingConfirmTableViewCell4Delegate, passSeatInfo{
    
    
    @IBOutlet weak var tblView: UITableView!
    
    var sourceAirport: Airport?
    var destAirport: Airport?
    var flights = [ScheduledFlights]()
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
    
    var flightsWithSeat = [ScheduledFlight]()
    var currentIndex : Int?
    
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1{
            let cell = tblView.dequeueReusableCell(withIdentifier: "BookingConfirmTableViewCell1") as! BookingConfirmTableViewCell1
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
            cell.arriveAirportFSCode.text = flights[indexPath.row - 1].arrivalAirportFsCode
            cell.arriveTime.text = toTime(time: flights[indexPath.row - 1].arrivalTime)
            cell.dateLabel.text = toDate(time: flights[indexPath.row - 1].departureTime)
            cell.departureAirportFSCode.text = flights[indexPath.row - 1].departureAirportFsCode
            cell.departureTime.text = toTime(time: flights[indexPath.row - 1].departureTime)
            cell.flightNumberLabel.text = "\(flights[indexPath.row - 1].carrierFsCode) \(flights[indexPath.row - 1].flightNumber)"
            cell.stopsLabel.text = "\(flights[indexPath.row - 1].stops) stops"
            departureDurationTime = getTimeInterval(indexPath: indexPath)
            cell.seat.text = flightsWithSeat[indexPath.row - 1].seat
            cell.delegate = self
            return cell
        }else if indexPath.row == flights.count{
            let cell = tblView.dequeueReusableCell(withIdentifier: "BookingConfirmTableViewCell1") as! BookingConfirmTableViewCell1
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
            cell.arriveAirportFSCode.text = flights[indexPath.row - 1].arrivalAirportFsCode
            cell.arriveTime.text = toTime(time: flights[indexPath.row - 1].arrivalTime)
            cell.dateLabel.text = toDate(time: flights[indexPath.row - 1].departureTime)
            cell.departureAirportFSCode.text = flights[indexPath.row - 1].departureAirportFsCode
            cell.departureTime.text = toTime(time: flights[indexPath.row - 1].departureTime)
            cell.flightNumberLabel.text = "\(flights[indexPath.row - 1].carrierFsCode) \(flights[indexPath.row - 1].flightNumber)"
            cell.stopsLabel.text = "\(flights[indexPath.row - 1].stops) stops"
            returnDurationTime = getTimeInterval(indexPath: indexPath)
            cell.seat.text = flightsWithSeat[indexPath.row - 1].seat
            cell.delegate = self
            return cell
        }else if indexPath.row == (flights.count + 1){
            let cell = tblView.dequeueReusableCell(withIdentifier: "BookingConfirmTableViewCell2") as! BookingConfirmTableViewCell2
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
            cell.scrollViewSetup()
            return cell
        }else if indexPath.row == (flights.count + 2){
            let cell = tblView.dequeueReusableCell(withIdentifier: "BookingConfirmTableViewCell3") as! BookingConfirmTableViewCell3
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
            return cell
        }else if indexPath.row == (flights.count + 3){
            let cell = tblView.dequeueReusableCell(withIdentifier: "BookingConfirmTableViewCell4") as! BookingConfirmTableViewCell4
            cell.backgroundColor = UIColor(white: 1, alpha: 0)
            cell.delegate = self
            return cell
        }else{
            let cell = tblView.dequeueReusableCell(withIdentifier: "BookingConfirmTableViewCell0")
            cell?.backgroundColor = UIColor(white: 1, alpha: 0)
            return cell!
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.backgroundColor = UIColor(white: 1, alpha: 0)
        backSourceAirport = destAirport?.city
        backDestAirport = sourceAirport?.city
        
        SourceAirportName = sourceAirport?.name
        DestAirportName = destAirport?.name
        backSourceAirportName = DestAirportName
        backDestAirportName = SourceAirportName
        
        for item in flights{
            let scheduledFlight = ScheduledFlight(flight: item, seat: "not chosen")
            flightsWithSeat.append(scheduledFlight)
        }
    }
    
    func didTapConfirm(_ cell: BookingConfirmTableViewCell4) {
        var str : String?
        str = "$153.5"
        str?.removeFirst()
        print(str)
        let request =  BTDropInRequest()
        request.venmoDisabled = false
        request.applePayDisabled = false
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
    
    func sendRequestPaymentToServer(nonce: String, amount: String) {
        let paymentURL = URL(string: "http://localhost:8000/checkout")!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(nonce)&amount=\(amount)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        SVProgressHUD.show()
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
    
        func purchaseSuccess() {
            if flights.count == 1{
                FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights[0], departureTrip: toDate(time: flights[0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, seat: flightsWithSeat[0].seat, completion: {()in
                })
            }else{
                FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights[0], departureTrip: toDate(time: flights[0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, seat: flightsWithSeat[0].seat, completion: {()in
                })
                FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights[1], departureTrip: toDate(time: flights[1].departureTime), departureCity: backSourceAirport!, arriveCity: backDestAirport!, departureAirportName: backSourceAirportName!, arriveAirportName: backDestAirportName!, durationTime: returnDurationTime!, seat: flightsWithSeat[1].seat, completion: {()in
                })
            }
            //let storyboard =  UIStoryboard(name: "", bundle: nil)
//            let rootController = storyboard.instantiateViewController(withIdentifier: "navigationSignIn")
//            self.window?.rootViewController = rootController
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    
    func didTapSeat(_ cell: BookingConfirmTableViewCell1) {
        guard let indexpath = tblView.indexPath(for: cell) else {
            return
        }
        currentIndex = indexpath.row - 1
        let storyboard = UIStoryboard(name: "Seat", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SeatPickerViewController") as! SeatPickerViewController
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func seatInfoPass(seatInfo: String) {
        flightsWithSeat[currentIndex!].seat = seatInfo
        tblView.reloadData()
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
    
    func getTimeInterval(indexPath : IndexPath) -> String {
        let depatureTime = flights[indexPath.row - 1].departureTime
        let arrivalTime = flights[indexPath.row - 1].arrivalTime
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

}
