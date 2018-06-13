//
//  Constants.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/11/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
class Constants {
    static let FlightStatsAPPId = "49703b32"
    static let FlightStatsAPPKey = "83f2bfd809a07190be987a5f31cf024d"
    static let apiURL = "https://api.flightstats.com/flex/schedules/rest/v1/json/from/%@/to/%@/departing/%@?appId=%@&appKey=%@&codeType=%@"
    static let icaoURL = "https://api.flightstats.com/flex/schedules/rest/v1/json/from/%@/to/%@/departing/%@?appId=%@&appKey=%@&codeType=ICAO"
    static let iataURL = "https://api.flightstats.com/flex/schedules/rest/v1/json/from/%@/to/%@/departing/%@?appId=%@&appKey=%@&codeType=IATA"
}
