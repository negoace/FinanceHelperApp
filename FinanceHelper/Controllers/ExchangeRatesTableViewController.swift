//
//  ExchangeRatesTableViewController.swift
//  FinanceHelper
//
//  Created by Boris on 6/3/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

class ExchangeRatesTableViewController: UITableViewController {

    @IBOutlet weak var eurLbl: UILabel!
    
    @IBOutlet weak var usdLbl: UILabel!
    
    @IBOutlet weak var eurExchRateLbl: UILabel!
    
    @IBOutlet weak var usdExchRateLbl: UILabel!
    
    @IBOutlet weak var eurCell: UITableViewCell!
    
    @IBOutlet weak var usdCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        tableView.tableFooterView = UIView()
//        tableView.isScrollEnabled = false
//        self.navigationItem.title = "Exchange Rates"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.0)]
        
        
        
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.backgroundColor = .clear
        
        
        eurCell.backgroundColor = .clear
        usdCell.backgroundColor = .clear
        eurLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        usdLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        eurExchRateLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        usdExchRateLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        
        
        getExchageRate()
       
        NotificationCenter.default.addObserver(self, selector: #selector(usdRateDidChange), name: NSNotification.Name(rawValue: "usdRateDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(eurRateDidChange), name: NSNotification.Name(rawValue: "eurRateDidChange"), object: nil)
    
    }
    
    @objc func usdRateDidChange() {
        usdExchRateLbl.text = String(ExchangeRates.shared.usdRate)
    }
    
    @objc func eurRateDidChange() {
        eurExchRateLbl.text = String(ExchangeRates.shared.eurRate)
    }
    private func getExchageRate(){
    
        let params: [String:Any] = [:/*"valcode":"EUR", "date":"20190603"*/]
        
       ExchangeRates.shared.makeRequest(params: params)
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
