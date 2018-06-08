//
//  BookingViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import ECSlidingViewController
class BookingViewController: UIViewController {
    @IBOutlet weak var sourceTextfield: UITextField!
    
    @IBOutlet weak var destinationTextfield: UITextField!
   
    @IBOutlet weak var dateTextfield1: UITextField!
    
    @IBOutlet weak var dateTextfield2: UITextField!
    
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var calender2Btn: UIButton!
    
    
    @IBAction func findFlightsClick(_ sender: Any) {
    }
    
    
    
    @IBAction func calender1Click(_ sender: Any) {
        
    }
    
    @IBAction func calender2Click(_ sender: Any) {
        
    }
    @IBAction func segment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dateTextfield2.isHidden = false
            calender2Btn.isHidden = false
        } else {
            dateTextfield2.isHidden = true
            calender2Btn.isHidden = true
        }
        
    }
    
    
    @IBAction func plusClick(_ sender: Any) {
        if Int(passengerLbl.text!)! < 6 {
            passengerLbl.text = String(Int(passengerLbl.text!)! + 1)
        }
    }
    
    
    @IBAction func minusClick(_ sender: Any) {
        if Int(passengerLbl.text!)! > 1 {
            passengerLbl.text = String(Int(passengerLbl.text!)! - 1)
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
    
    func initialze() {
        passengerLbl.layer.borderWidth = 0.5
        passengerLbl.text = "1"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "generalbackground")!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialze()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
