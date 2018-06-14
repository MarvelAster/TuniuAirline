//
//  MyBookingViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import UserNotifications

class MyBookingViewController: UIViewController {
    
    @IBOutlet weak var durationTimeLabel: UILabel!
    var date = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.weekday = 3
        date.hour = 14
        date.minute = 34
        timeNotifications(date: date) { (flag) in
            
        }
    }
    
    @IBAction func btnClick(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }

    func timeNotifications(date: DateComponents, completion: @escaping (Bool)->Void) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Flight Reminder"
        content.body = "Your Flight will take off after 2 hours"
        
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil{
                completion(false)
            }else{
                completion(true)
            }
        }
    }
}
