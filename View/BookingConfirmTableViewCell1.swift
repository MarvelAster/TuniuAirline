//
//  BookingConfirmTableViewCell1.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/18/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class BookingConfirmTableViewCell1: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var departureAirportFSCode: UILabel!
    
    @IBOutlet weak var stopsLabel: UILabel!
    @IBOutlet weak var arriveTime: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arriveAirportFSCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
