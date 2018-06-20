//
//  BookingConfirmViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/18/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class BookingConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, BookingConfirmTableViewCell4Delegate {
    
    
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
    }
    
    func didTapConfirm(_ cell: BookingConfirmTableViewCell4) {
        if flights.count == 1{
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights[0], departureTrip: toDate(time: flights[0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, completion: {()in
            })
        }else{
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights[0], departureTrip: toDate(time: flights[0].departureTime), departureCity: sourceAirport!.city!, arriveCity: destAirport!.city!, departureAirportName: SourceAirportName!, arriveAirportName: DestAirportName!, durationTime: departureDurationTime!, completion: {()in
            })
            FirebaseHandler.sharedInstance.uploadBookedFlightDetail(flights: flights[1], departureTrip: toDate(time: flights[1].departureTime), departureCity: backSourceAirport!, arriveCity: backDestAirport!, departureAirportName: backSourceAirportName!, arriveAirportName: backDestAirportName!, durationTime: returnDurationTime!, completion: {()in
            })
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
