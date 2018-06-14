//
//  FlightSearchResultViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/11/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class FlightSearchResultViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var banner: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    
    var sourceAirport : Airport?
    var destinationAirport : Airport?
    
    var allFlights : [ScheduledFlights]?
    
    var departureTrip : String?
    var returnTrip : String?
    
    var segmentTag : Int?
    var flag = false
    
    var choosedFlights : [ScheduledFlights] = []
    
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
    
    func getTimeInterval(indexPath : IndexPath) -> String {
        let depatureTime = allFlights![indexPath.row].departureTime
        let arrivalTime = allFlights![indexPath.row].arrivalTime
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
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allFlights == nil {
            return 0
        } else {
            return (allFlights?.count)!
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "FlightSearchResultTableViewCell") as! FlightSearchResultTableViewCell
        cell.timeFromTo.text =  "\(toTime(time: allFlights![indexPath.row].departureTime))-\(toTime(time: allFlights![indexPath.row].arrivalTime))"
        cell.airline.text = "\(allFlights![indexPath.row].carrierFsCode) Airline \(allFlights![indexPath.row].flightNumber)"
        cell.interval.text = "\(getTimeInterval(indexPath: indexPath))(\(allFlights![indexPath.row].stops) stops)"
        cell.cityFromTo.text = "\(String(describing: (sourceAirport?.iata == "" ? sourceAirport?.icao : sourceAirport?.iata)!))-\(String(describing: (destinationAirport?.iata == "" ? destinationAirport?.icao : destinationAirport?.iata)!))"
        return cell
        
    }
    //MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        
        if self.segmentTag == 0 {
        //round trip choosed
            flag = true
            let controller = storyboard.instantiateViewController(withIdentifier: "FlightSearchResultViewController") as! FlightSearchResultViewController
            controller.segmentTag = 1
            controller.sourceAirport = self.sourceAirport!
            controller.destinationAirport = self.destinationAirport!
            controller.departureTrip = self.returnTrip
            controller.flag = flag
            if choosedFlights.count > 0 {
                choosedFlights.popLast()
            }
            self.choosedFlights.append(self.allFlights![indexPath.row])
            controller.choosedFlights = self.choosedFlights
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
        //one-way trip choosed
            let controller1 = storyboard.instantiateViewController(withIdentifier: "FlightDetailViewController") as! FlightDetailViewController
            if flag == false {
                if choosedFlights.count > 0 {
                    choosedFlights.popLast()
                }
            } else {
                if choosedFlights.count > 1 {
                    choosedFlights.popLast()
                }
            }
            self.choosedFlights.append(self.allFlights![indexPath.row])
            controller1.flights = self.choosedFlights
            controller1.departureTrip = self.departureTrip
            controller1.returnTrip = self.returnTrip
            navigationController?.pushViewController(controller1, animated: true)
        }
    }
    
    func initialize() {
        let departureCity = sourceAirport?.city
        let arrivalCity = destinationAirport?.city
        let departureIATA = sourceAirport?.iata
        let arrivalIATA = destinationAirport?.iata
        let departureICAO = sourceAirport?.icao
        let arrivalICAO = destinationAirport?.icao
        var passURL : String!
        if departureIATA?.count != 3 || departureIATA?.count != 3 {
            //TODO:
            banner.text = "\(departureCity!)(\(departureICAO!))-\(arrivalCity!)(\(arrivalICAO!))"
            passURL = String(format: Constants.icaoURL, departureICAO!, arrivalICAO!, departureTrip!, Constants.FlightStatsAPPId, Constants.FlightStatsAPPKey)
        } else {
            banner.text = "\(departureCity!)(\(departureIATA!))-\(arrivalCity!)(\(arrivalIATA!))"
            passURL = String(format: Constants.iataURL, departureIATA!, arrivalIATA!, departureTrip!, Constants.FlightStatsAPPId, Constants.FlightStatsAPPKey)
        }
        FlightStatsAPIHandler.shareInstance.getAllFlightsBasedOnSearch(passURL: passURL, completion: {
            (allFlights, error) in
            self.allFlights = allFlights?.scheduledFlights
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
