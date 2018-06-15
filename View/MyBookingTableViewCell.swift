//
//  MyBookingTableViewCell.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/12/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class MyBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var tripLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var departureCityFSCode: UILabel!
    @IBOutlet weak var arriveTimeLabel: UILabel!
    @IBOutlet weak var arriveCityFSCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
