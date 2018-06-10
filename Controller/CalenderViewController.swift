//
//  CalenderViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/8/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import JTAppleCalendar
class CalenderViewController: UIViewController {
    let formatter = DateFormatter()
    @IBOutlet weak var collectionView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    var selectedDate : Int?
    
    
    @IBAction func cancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmClick(_ sender: Any) {
        if selectedDate == nil {
            dismiss(animated: true, completion: nil)
        } else {
            print("Month : \(month.text!) Date : \(selectedDate!) Year : \(year.text!)")
            dismiss(animated: true, completion: nil)
        }
    }
    func setupCalendarView() {
        //setup calendar space
        collectionView.minimumInteritemSpacing = 0
        collectionView.minimumLineSpacing = 0
        //setup labels
        collectionView.visibleDates({
            (visibleDates) in
            self.setupViewOfCalendar(from: visibleDates)
        })
    }
    func setupViewOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
    }
    func handleCelltextColor(view : JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CalenderCell else {
            return
        }
        if cellState.isSelected{
            validCell.lbl.textColor = UIColor.gray
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.lbl.textColor = UIColor.white
            } else {
                validCell.lbl.textColor = UIColor.gray
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "generalbackground")!)
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
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

extension CalenderViewController: JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 06 06")!
        let endDate = formatter.date(from : "2020 12 30")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
}
extension CalenderViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
        //cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.lbl.text = cellState.text
        if cellState.isSelected {
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
        handleCelltextColor(view: cell, cellState: cellState)
        
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalenderCell else {
            return
        }
        validCell.selectedView.isHidden = false
        handleCelltextColor(view: cell, cellState: cellState)
        self.selectedDate = Int(validCell.lbl.text!)!
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalenderCell else {
            return
        }
        validCell.selectedView.isHidden = true
        handleCelltextColor(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewOfCalendar(from: visibleDates)
    }
}

