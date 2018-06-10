//
//  BookingViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import ECSlidingViewController
class BookingViewController: UIViewController,UITextFieldDelegate, AirportSearchDelegate, CalendarDelegate {
    
    @IBOutlet weak var sourceTextfield: UITextField!
    
    @IBOutlet weak var destinationTextfield: UITextField!
   
    @IBOutlet weak var dateTextfield1: UITextField!
    
    @IBOutlet weak var dateTextfield2: UITextField!
    
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var calender2Btn: UIButton!
    
    
    @IBAction func findFlightsClick(_ sender: Any) {
    }
    
    //MARK: -AirportSearchDelegate
    func airportSelect(tag : Int, airportIata: String, airportInfo: Airport) {
        if tag == 101 {
            sourceTextfield.text = airportIata
        } else{
            destinationTextfield.text = airportIata
        }
    }
    
    //MARK: -CalendarDelegate
    func passDate(tag: Int, date: String) {
        if tag == 1 {
            dateTextfield1.text = date
        } else {
            dateTextfield2.text = date
        }
    }
    @IBAction func calender1Click(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        controller.tag = sender.tag
        controller.delegate = self
        present(controller, animated: true, completion: nil)
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
    
    //MARK: -TextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AirportSearchViewController") as! AirportSearchViewController
        controller.tag = textField.tag
        controller.delegate = self
        present(controller, animated: true, completion: nil)
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
