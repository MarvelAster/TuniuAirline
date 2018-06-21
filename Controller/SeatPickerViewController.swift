//
//  SeatPickerViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/19/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
import SVProgressHUD
protocol passSeatInfo {
    func seatInfoPass(seatInfo : String)
}
class SeatPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,SeatCellDelegate {
    
    
    var seat : [Seat] = []
    var tmpNum : IndexPath?

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var lastCell : SeatCollectionViewCell?
    
    var delegate : passSeatInfo?
    
    
    func seatChoosed(cell: SeatCollectionViewCell) {
        if lastCell != nil {
            lastCell?.seat.isSelected = !(lastCell?.seat.isSelected)!
        }
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        cell.seat.isSelected = !cell.seat.isSelected
        lastCell = cell
        tmpNum = indexPath
        let alter = UIAlertController(title: "Seat Choose", message: "Seat Price : $\(seat[indexPath.row].seatPrice!)", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionConfirm = UIAlertAction(title: "Confirm", style: .default, handler: {
            [unowned self] action in
            SVProgressHUD.show()
            FirebaseHandler.sharedInstance.seatChoosed(seatId: self.seat[indexPath.row].seatId!, completion: {
                (error) in
                SVProgressHUD.dismiss()
                if error == nil {
//                    self.tmpNum = nil
                    self.seat[indexPath.row].seatStatus = 1
                    let alter1 = UIAlertController(title: "Success", message: "Seat choosed", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "OK", style: .default, handler: {
                        [unowned self] action in
                        let seatC = ["A", "B", "C", "D"]
                        let row : String = String((indexPath.row / 4 + 1))
                        let col : String = seatC[(indexPath.row % 4)]
                        let seatDetail = "Row \(row), Seat \(col)"
                        self.delegate?.seatInfoPass(seatInfo: seatDetail)
                        self.dismiss(animated: true, completion: nil)
                    })
                    alter1.addAction(action1)
                    self.present(alter1, animated: true, completion: nil)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } else {
                    let alter1 = UIAlertController(title: "Error", message: "Seat choosed fail, please try again", preferredStyle: .alert)
                    let action1 = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alter1.addAction(action1)
                    self.present(alter1, animated: true, completion: nil)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            })
        })
        alter.addAction(actionCancel)
        alter.addAction(actionConfirm)
        present(alter, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seat.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as! SeatCollectionViewCell
        cell.delegate = self
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = UIColor(white: 0, alpha: 0.85)
        if self.tmpNum == indexPath {
            cell.seat.setImage(UIImage(named: "seat_selected"), for: .normal)
            cell.seat.isEnabled = true
            cell.seat.isSelected = true
        }else if seat[indexPath.row].seatStatus == 1 {
            cell.seat.setImage(UIImage(named: "seat_unavailable"), for: .normal)
            cell.seat.isEnabled = false
            cell.seat.isSelected = false
        } else {
            cell.seat.setImage(UIImage(named: "seat_available"), for: .normal)
            cell.seat.isEnabled = true
            cell.seat.isSelected = false
        }
        return cell
    }
    
    func collectionViewLayoutSetting() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView!.collectionViewLayout = layout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = UIColor(white: 0, alpha: 0.85)
        collectionViewLayoutSetting()
        //just call it once, initail seat databae
//        FirebaseHandler.sharedInstance.seatInitialize()
        // Do any additional setup after loading the view.
        FirebaseHandler.sharedInstance.getAllSeatInfomation(completion: {
            (seats) in
            self.seat = seats
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        })
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
