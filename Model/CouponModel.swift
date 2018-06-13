//
//  CouponModel.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/10/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation
import UIKit

class Coupon{
    var image: UIImage?
    var couponCode: String?
    var validStartDate: String?
    var validEndDate: String?
    var discount: String?
    
    init(image: UIImage, couponCode: String, validStartDate: String, validEndDate:String, discount:String) {
        self.image = image
        self.couponCode = couponCode
        self.validStartDate = validStartDate
        self.validEndDate = validEndDate
        self.discount = discount
    }
}
