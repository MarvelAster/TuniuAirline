//
//  SeatModel.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/19/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
class Seat {
    var seatNumber : Int?
    var seatStatus : Int?
    var seatPrice : Int?
    var seatId : String?
    init(seatNumber : Int, seatStatus : Int, seatPrice : Int, seatId : String) {
        self.seatNumber = seatNumber
        self.seatStatus = seatStatus
        self.seatPrice = seatPrice
        self.seatId = seatId
    }
}
