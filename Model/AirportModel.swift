//
//  AirportModel.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/9/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
class Airport {
    var city : String?
    var country : String?
    var elevation : Int?
    var iata : String?
    var icao : String?
    var lat : Double?
    var lon : Double?
    var name : String?
    var state : String?
    var tz : String?
    init(city : String, country : String, elevation : Int, iata : String, icao : String, lat : Double, lon : Double, name : String, state : String, tz : String) {
        self.city = city
        self.country = country
        self.elevation = elevation
        self.iata = iata
        self.icao = icao
        self.lat = lat
        self.lon = lon
        self.name = name
        self.state = state
        self.tz = tz
    }
}
