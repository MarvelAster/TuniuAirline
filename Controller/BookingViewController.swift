//
//  BookingViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/7/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import ECSlidingViewController
import SVProgressHUD
class BookingViewController: UIViewController,UITextFieldDelegate, AirportSearchDelegate, CalendarDelegate {
    
    @IBOutlet weak var sourceTextfield: UITextField!
    
    @IBOutlet weak var destinationTextfield: UITextField!
   
    @IBOutlet weak var dateTextfield1: UITextField!
    
    @IBOutlet weak var dateTextfield2: UITextField!
    
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var calender2Btn: UIButton!
    //passed airports
    var sourceAirport : Airport?
    var destinationAirport : Airport?
    
    //pass segment tag
    var segmentTag = 0
    
    @IBAction func findFlightsClick(_ sender: Any) {
        if segmentTag == 0 {
            if dateTextfield1.text == "" || dateTextfield2.text == "" {
                alter1()
                return
            }
        }
        if segmentTag == 1 {
            if dateTextfield1.text == "" {
                alter1()
                return
            }
        }
//        let storyboard = UIStoryboard(name: "Calendar", bundle: nil )
//        let controller = storyboard.instantiateViewController(withIdentifier: "FlightSearchResultViewController") as! FlightSearchResultViewController
        
        let storyboard = UIStoryboard(name: "FoldTableView", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FlightSearchFoldViewController") as! FlightSearchFoldViewController
        controller.segmentTag = self.segmentTag
        controller.sourceAirport = self.sourceAirport!
        controller.destinationAirport = self.destinationAirport!
        controller.departureTrip = dateTextfield1.text
        controller.returnTrip = dateTextfield2.text
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    //MARK: -AirportSearchDelegate
    func airportSelect(tag : Int, airportIata: String, airportInfo: Airport) {
        if tag == 101 {
            sourceTextfield.text = airportIata
            self.sourceAirport = airportInfo
        } else{
            destinationTextfield.text = airportIata
            self.destinationAirport = airportInfo
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
            self.segmentTag = 0
            dateTextfield2.isHidden = false
            calender2Btn.isHidden = false
        } else {
            self.segmentTag = 1
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
    func alter() {
        let alter = UIAlertController(title: "Warning", message: "return date must be later than your depature date", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            [unowned self] action in
            self.dateTextfield2.text = ""
        })
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    func alter1() {
        let alter = UIAlertController(title: "Warning", message: "select a date first", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }
    //MARK: -TextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AirportSearchViewController") as! AirportSearchViewController
        controller.tag = textField.tag
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if dateTextfield1.text != "" && dateTextfield2.text != "" && dateTextfield1.text! > dateTextfield2.text! || dateTextfield1.text == "" && dateTextfield2.text != "" {
            alter()
        }
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
