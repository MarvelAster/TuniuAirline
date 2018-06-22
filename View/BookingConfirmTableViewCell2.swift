//
//  BookingConfirmTableViewCell2.swift
//  TuniuAirlineProject
//
//  Created by 甘忠达 on 6/18/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class BookingConfirmTableViewCell2: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    let couponInfo = [imageInfo(image: UIImage(named: "comfort"), title: "Upgrade To First Class", fromLabel: "from $", label1: "per passenger / entire trip", label2: "include taxes & fees", price: "368"), imageInfo(image: UIImage(named: "mainCabin"), title: "Update To Main", fromLabel: "from $", label1: "per passenger / entire trip", label2: "include taxes & fees", price: "228")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//        pageController.currentPage = Int(pageNumber)
//    }
    
    func scrollViewSetup() {
        scrollView.contentSize.width = (UIScreen.main.bounds.width - 20) * CGFloat(couponInfo.count)
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        var frameLable1 = CGRect(x: 0, y: 0, width: 0, height: 0)
        var frameLabel2 = CGRect(x: 0, y: 0, width: 0, height: 0)
        var frameLabel3 = CGRect(x: 0, y: 0, width: 0, height: 0)
        var frameLabel4 = CGRect(x: 0, y: 0, width: 0, height: 0)
        var frameLabel5 = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        
        for index in 0..<couponInfo.count{
            frame.origin.x = (UIScreen.main.bounds.width - 20) * CGFloat(index)
            frame.size.height = 210
            frame.size.width = (UIScreen.main.bounds.width - 20)
            
            frameLable1.origin.x = (UIScreen.main.bounds.width - 20) * CGFloat(index)
            frameLable1.origin.y = 240
            frameLable1.size.height = 20
            frameLable1.size.width = 200
            
            frameLabel2.origin.x = (UIScreen.main.bounds.width - 20) * CGFloat(index)
            frameLabel2.origin.y = 260
            frameLabel2.size.height = 20
            frameLabel2.size.width = 150
            
            frameLabel3.origin.x = (UIScreen.main.bounds.width - 20) * CGFloat(index)
            frameLabel3.origin.y = 210
            frameLabel3.size.height = 30
            frameLabel3.size.width = 220
            
            frameLabel4.origin.x = (UIScreen.main.bounds.width - 20) * CGFloat(index) + (UIScreen.main.bounds.width - 60)
            frameLabel4.origin.y = 230
            frameLabel4.size.height = 30
            frameLabel4.size.width = 40
            
            frameLabel5.origin.x = (UIScreen.main.bounds.width - 20) * CGFloat(index) + (UIScreen.main.bounds.width - 100)
            frameLabel5.origin.y = 230
            frameLabel5.size.height = 20
            frameLabel5.size.width = 40
            
            let lable1 = UILabel(frame: frameLable1)
            lable1.text = self.couponInfo[index].label1
            lable1.font = UIFont.boldSystemFont(ofSize: 13)
            
            let label2 = UILabel(frame: frameLabel2)
            label2.text = self.couponInfo[index].label2
            label2.font = UIFont.boldSystemFont(ofSize: 13)
            
            let label3 = UILabel(frame: frameLabel3)
            label3.text = self.couponInfo[index].title
            label3.font = UIFont.boldSystemFont(ofSize: 20)
            
            let label4 = UILabel(frame: frameLabel4)
            label4.text = self.couponInfo[index].price
            label4.font = UIFont.boldSystemFont(ofSize: 20)
            
            let label5 = UILabel(frame: frameLabel5)
            label5.text = self.couponInfo[index].fromLabel
            label5.font = UIFont.boldSystemFont(ofSize: 12)
            
            let imageView = UIImageView(frame: frame)
            imageView.image = couponInfo[index].image
            self.scrollView.addSubview(imageView)
            self.scrollView.addSubview(lable1)
            self.scrollView.addSubview(label2)
            self.scrollView.addSubview(label3)
            self.scrollView.addSubview(label4)
            self.scrollView.addSubview(label5)
        }
        scrollView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

struct imageInfo{
    var image: UIImage?
    var title: String?
    var fromLabel = "from $"
    var label1 = "per passenger / entire trip"
    var label2 = "include taxes & fees"
    var price: String?
}
