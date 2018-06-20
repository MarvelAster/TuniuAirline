//
//  CouponViewController.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/10/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class CouponViewController: UIViewController {

    @IBOutlet weak var couponImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var couponCodeLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    var couponInfo: Coupon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background-1")!)
        couponImage.image = couponInfo?.image
        descriptionLabel.text = couponInfo?.discount
        couponCodeLabel.text = couponInfo?.couponCode
        endDateLabel.text = couponInfo?.validEndDate
    }

    @IBAction func copyBtnAction(_ sender: Any) {
        UIPasteboard.general.string = couponCodeLabel.text
        
    }

}
