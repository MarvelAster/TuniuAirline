//
//  ViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import ECSlidingViewController
class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var couponInfo = [Coupon]()
    
    @IBAction func btnClick(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background-1")!)
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTap)
        FirebaseHandler.sharedInstance.getCouponInfo { (coupon) in
            print(coupon)
            self.couponInfo = coupon
            self.couponInfo = self.couponInfo.sorted(by: {$0.validStartDate! < $1.validStartDate!})
            self.scrollViewSetup()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    func scrollViewSetup() {
        pageControl.numberOfPages = couponInfo.count
        for index in 0..<couponInfo.count{
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imageView = UIImageView(frame: frame)
            imageView.image = couponInfo[index].image
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(couponInfo.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CouponViewController") as! CouponViewController
        controller.couponInfo = couponInfo[pageControl.currentPage]
        navigationController?.pushViewController(controller, animated: true)
    }

}

