//
//  CitySearchTableViewCell.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/8/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {

    @IBOutlet weak var airportName: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
