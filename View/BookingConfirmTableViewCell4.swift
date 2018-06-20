//
//  BookingConfirmTableViewCell4.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/18/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

@objc protocol BookingConfirmTableViewCell4Delegate{
    func didTapConfirm(_ cell: BookingConfirmTableViewCell4) ->Void
}

class BookingConfirmTableViewCell4: UITableViewCell {

    @IBOutlet weak var confirmBtnOutlet: UIButton!
    
    var delegate: BookingConfirmTableViewCell4Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func confirmBtnAction(_ sender: UIButton) {
        delegate?.didTapConfirm(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
