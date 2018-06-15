//
//  FlightModel.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/11/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
import UIKit

struct FlightJSON : Codable {
    var scheduledFlights : [ScheduledFlights]
}

struct ScheduledFlights : Codable {
    var carrierFsCode : String
    var flightNumber : String
    var departureAirportFsCode : String
    var arrivalAirportFsCode : String
    var stops : Int
    var departureTerminal : String
    var arrivalTerminal : String
    var departureTime : String
    var arrivalTime : String
}

struct BookedFlightsInfo{
    var carrierFsCode : String
    var flightNumber : String
    var departureAirportFsCode : String
    var arrivalAirportFsCode : String
    var stops : Int
    var departureTerminal : String
    var arrivalTerminal : String
    var departureTime : String
    var arrivalTime : String
    var departureCity: String
    var arriveCity: String
    var departureDate: String
    var flightKey: String
    var departureAirportName: String
    var arriveAirportName: String
    var durationTime: String
}

