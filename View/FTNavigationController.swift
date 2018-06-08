//
//  FTNavigationController.swift
//  Ardhi
//
//  Created by Alex Zdorovets on 9/17/15.
//  Copyright (c) 2015 Solutions 4 Mobility. All rights reserved.
//

import UIKit
import ECSlidingViewController
class FTNavigationController: UINavigationController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAppereance(UIColor.white, textColor: UIColor.white, barStyle: UIBarStyle.black)
        if let gesture = self.slidingViewController()?.panGesture {
            gesture.cancelsTouchesInView = false
            self.view.addGestureRecognizer(gesture)
        }
       // self.navigationBar.isLocalized = true
    }
    func setupAppereance(_ tintColor: UIColor, textColor: UIColor, barStyle: UIBarStyle) {
        let font = UIFont(name: "LandRoverOT4-Medium", size: 18)!
        self.navigationBar.barStyle = barStyle
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : textColor, NSAttributedStringKey.font : font]
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.barTintColor = tintColor
        self.navigationBar.tintColor = tintColor
        if let gesture = self.slidingViewController()?.panGesture {
            gesture.cancelsTouchesInView = false
            self.view.addGestureRecognizer(gesture)
        }
        self.navigationBar.shadowImage = UIImage()
    }
}
