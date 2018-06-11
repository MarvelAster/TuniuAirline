//
//  CouponModel.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/10/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import Foundation

class Coupon{
    var imageName: String?
    var couponCode: String?
    var validStartDate: String?
    var validEndDate: String?
    var discount: String?
    
    init(imageName: String, couponCode: String, validStartDate: String, validEndDate:String, discount:String) {
        self.imageName = imageName
        self.couponCode = couponCode
        self.validStartDate = validStartDate
        self.validEndDate = validEndDate
        self.discount = discount
    }
}
