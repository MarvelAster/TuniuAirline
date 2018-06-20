//
//  FlightSearchFoldViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/14/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import FoldingCell
class FlightSearchFoldViewController: UITableViewController {
    
    var price : Double = 0.0
    @IBOutlet weak var tblView: UITableView!
    var sourceAirport : Airport?
    var destinationAirport : Airport?
    
    var allFlights : [ScheduledFlights]!
    
    var departureTrip : String?
    var returnTrip : String?
    
    var segmentTag : Int?
    var flag = false
    
    var choosedFlights : [ScheduledFlights] = []
    
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
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
            passURL = String(format: Constants.icaoURL, departureICAO!, arrivalICAO!, departureTrip!, Constants.FlightStatsAPPId, Constants.FlightStatsAPPKey)
        } else {
            passURL = String(format: Constants.iataURL, departureIATA!, arrivalIATA!, departureTrip!, Constants.FlightStatsAPPId, Constants.FlightStatsAPPKey)
        }
        FlightStatsAPIHandler.shareInstance.getAllFlightsBasedOnSearch(passURL: passURL, completion: {
            (allFlights, error) in
            self.allFlights = allFlights?.scheduledFlights
            DispatchQueue.main.async {
                self.setup()
                self.tblView.reloadData()
            }
        })
    }
    var cellHeights: [CGFloat] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: self.allFlights.count)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "generalbackground")!)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
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

extension FlightSearchFoldViewController : FoldCellDelegate {
    
    func confirmBtnClick(cell: FlightSearchFoldTableViewCell) {
        guard let indexPath = tblView.indexPath(for: cell) else {
            return
        }
        if self.segmentTag == 0 {
            //round trip choosed
            let storyboard = UIStoryboard(name: "FoldTableView", bundle: nil)
            flag = true
            let controller = storyboard.instantiateViewController(withIdentifier: "FlightSearchFoldViewController") as! FlightSearchFoldViewController
            controller.segmentTag = 1
            controller.sourceAirport = self.destinationAirport!
            controller.destinationAirport = self.sourceAirport!
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
            let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
            let controller1 = storyboard.instantiateViewController(withIdentifier: "BookingConfirmViewController") as! BookingConfirmViewController
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
            controller1.sourceAirport = self.sourceAirport
            controller1.destAirport = self.destinationAirport
            navigationController?.pushViewController(controller1, animated: true)
        }
    }
    
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if allFlights == nil {
            return 0
        } else {
            return (allFlights?.count)!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightSearchFoldTableViewCell", for: indexPath) as! FlightSearchFoldTableViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.backgroundColor = UIColor(white: 1, alpha: 0.2)
        cell.delegate = self
        cell.flightNumber.text = "NO.\(String(allFlights[indexPath.row].flightNumber))"
        cell.dateLabel.text = Time.shareTimeInstance.toDate(time: allFlights[indexPath.row].departureTime)
        cell.durationTimeLabel.text = "\(Time.shareTimeInstance.getTimeInterval(startTime: allFlights[indexPath.row].departureTime, endTime: allFlights[indexPath.row].arrivalTime))(\(allFlights[indexPath.row].stops)stops)"
        cell.arriveTimeLabel.text = Time.shareTimeInstance.toTime(time: allFlights[indexPath.row].arrivalTime)
        cell.departureTimeLabel.text = Time.shareTimeInstance.toTime(time: allFlights[indexPath.row].departureTime)
        cell.departureCityLabel.text = sourceAirport?.city
        cell.arriveCityLabel.text = destinationAirport?.city
        cell.departureTerminalLabel.text = allFlights[indexPath.row].departureTerminal
        cell.arriveTerminalLabel.text = allFlights[indexPath.row].arrivalTerminal
        cell.airlineCompanyLabel.text = "\(allFlights[indexPath.row].carrierFsCode) Airlines"
        cell.timeFromTo.text = "\(Time.shareTimeInstance.toTime(time: allFlights[indexPath.row].departureTime))-\(Time.shareTimeInstance.toTime(time: allFlights[indexPath.row].arrivalTime))"
        cell.departureAirport.text = sourceAirport?.name
        cell.arrivalAirport.text = destinationAirport?.name
        FirebaseHandler.sharedInstance.downloadUserInfoInProfileViewController(completion: {
            (name, email, img) in
            DispatchQueue.main.async {
                cell.userName.text = name
                cell.userImg.image = img
            }
        })
        return cell
    }
    
    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as FlightSearchFoldTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    

    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}
