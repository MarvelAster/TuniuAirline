//
//  FlightSearchFoldTableViewCell.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/14/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import FoldingCell
protocol FoldCellDelegate {
    func confirmBtnClick(cell : FlightSearchFoldTableViewCell)
}
class FlightSearchFoldTableViewCell: FoldingCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var closeNumberLabel : UILabel!
    @IBOutlet weak var flightNumber : UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arriveTimeLabel: UILabel!
    @IBOutlet weak var departureCityLabel: UILabel!
    @IBOutlet weak var arriveCityLabel: UILabel!
    @IBOutlet weak var departureTerminalLabel: UILabel!
    @IBOutlet weak var arriveTerminalLabel: UILabel!
    @IBOutlet weak var airlineCompanyLabel: UILabel!
    
    @IBOutlet weak var timeFromTo: UILabel!
    
    @IBOutlet weak var departureAirport: UILabel!
    
    @IBOutlet weak var arrivalAirport: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    var delegate : FoldCellDelegate?
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = "#\(String(number))"
        }
    }
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    @IBAction func confirmClick(sender : AnyObject) {
        self.delegate?.confirmBtnClick(cell: self)
    }
}
