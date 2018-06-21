//
//  SeatCollectionViewCell.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/19/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
protocol SeatCellDelegate{
    func seatChoosed(cell : SeatCollectionViewCell)
}
class SeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seat: UIButton!
    var delegate : SeatCellDelegate?
    @IBAction func seatClick(_ sender: Any) {
        delegate?.seatChoosed(cell: self)
    }
//    override func prepareForReuse() {
//        seat.isEnabled = true
//        seat.isSelected = false
//        seat.setImage(UIImage(named: "seat_available"), for: .normal)
//    }
}
