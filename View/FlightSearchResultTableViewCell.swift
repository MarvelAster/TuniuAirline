//
//  FlightSearchResultTableViewCell.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/11/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class FlightSearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var timeFromTo: UILabel!
    
    @IBOutlet weak var airline: UILabel!
    
    @IBOutlet weak var interval: UILabel!
    
    @IBOutlet weak var cityFromTo: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBAction func viewDetailClick(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
