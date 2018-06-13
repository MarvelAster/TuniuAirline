//
//  FlightStatsAPIHandler.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/11/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
import UIKit

final class FlightStatsAPIHandler{
    static let shareInstance = FlightStatsAPIHandler()
    private init() {}
    
    func getAllFlightsBasedOnSearch(passURL : String, completion :@escaping (FlightJSON?, Error?) -> Void) {
        guard let url = URL(string: passURL) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error)
                completion(nil, error)
            } else {
                do {
                    let decodeData = try JSONDecoder().decode(FlightJSON.self, from: data!)
                    print(decodeData)
                    completion(decodeData, nil)
                }catch {
                    print(error)
                }
            }
        }).resume()
    }
    
}
