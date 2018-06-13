//
//  FlightDetailViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/12/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit

class FlightDetailViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tblView: UITableView!
    
    var flights: [ScheduledFlights]?
    var departureTrip : String?
    var returnTrip : String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flights == nil {
            return 0
        } else {
            return (flights?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "FlightDetialTableViewCell") as! FlightDetialTableViewCell
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
