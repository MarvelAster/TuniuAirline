//
//  AirportSearchViewController.swift
//  TuniuAirlineProject
//
//  Created by Chuanqi Huang on 6/8/18.
//  Copyright © 2018 Chuanqi Huang. All rights reserved.
//

import UIKit
protocol AirportSearchDelegate {
    func airportSelect(tag : Int, airportIata: String, airportInfo : Airport)
}
class AirportSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tag :Int?
    
    
    var airport : [Airport]?
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var delegate : AirportSearchDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if airport == nil {
            return 0
        } else {
            return (airport?.count)!
        }
    }
    //MARK: -SearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            getAirportResult(toSearch: searchText)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.airport = []
        searchBar.text = ""
        self.tblView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: -TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curAirport = self.airport![indexPath.row]
        let curIata = curAirport.iata
        let curCity = curAirport.city
        var passValue : String?
        if curIata != "" {
            passValue = "\(curCity!)(\(curIata!))"
        } else {
            passValue = "\(curCity!)"
        }
        print(passValue!)
        delegate?.airportSelect(tag : self.tag!, airportIata : passValue!, airportInfo : curAirport)
        dismiss(animated: true, completion: nil)
    }
    //MARK: -TableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CitySearchTableViewCell") as! CitySearchTableViewCell
        cell.airportName.text = self.airport![indexPath.row].name
        cell.location.text = self.airport![indexPath.row].city
        return cell
    }
    
    
    
    func getAirportResult(toSearch : String) {
        FirebaseHandler.sharedInstance.databaseQueryByCityName(city: toSearch, completion: {
            (airport) in
                self.airport = airport
                self.tblView.reloadData()
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView(frame: .zero)
        self.searchBar.becomeFirstResponder()
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
