//
//  BookingConfirmTableViewCell1.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/18/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

protocol BookingConfirmTableViewCell1Delegate {
    func didTapSeat(_ cell: BookingConfirmTableViewCell1) -> Void
}

class BookingConfirmTableViewCell1: UITableViewCell {

    @IBOutlet weak var seat: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var departureAirportFSCode: UILabel!
    
    @IBOutlet weak var stopsLabel: UILabel!
    @IBOutlet weak var arriveTime: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arriveAirportFSCode: UILabel!
    
    var delegate: BookingConfirmTableViewCell1Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func chooseSeatBtnAction(_ sender: UIButton) {
        delegate?.didTapSeat(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
