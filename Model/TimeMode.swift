//
//  TimeMode.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/14/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
class Time {
    static let shareTimeInstance = Time()
    private init(){}
    
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
        format.dateFormat = "yyyy-MM-dd"
        let date1 = format.string(from: date!)
        //print(date1)
        return date1
    }
    
    func getTimeInterval(startTime:String, endTime:String) -> String {
        let depatureTime = startTime
        let arrivalTime = endTime
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
