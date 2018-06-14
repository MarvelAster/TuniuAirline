//
//  FlightDetialTableViewCell.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/12/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class FlightDetialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var stopsLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arriveTimeLabel: UILabel!
    @IBOutlet weak var departureCityLabel: UILabel!
    @IBOutlet weak var arriveCityLabel: UILabel!
    @IBOutlet weak var departureTerminalLabel: UILabel!
    @IBOutlet weak var arriveTerminalLabel: UILabel!
    @IBOutlet weak var airlineCompanyLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
