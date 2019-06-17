//
//  IncomeStatisticsViewController.swift
//  FinanceHelper
//
//  Created by Boris on 6/17/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit
import RealmSwift
class IncomeStatisticsViewController: UIViewController {

    @IBOutlet weak var statisticsTableView: UITableView!
    
    var historyArray: [IncomeHistory] = []
    var incomeHistorySingleton = IncomeHistory.shared
    var account = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupStatisticsTableView()
        self.setupBackgroundImage()
      
       historyArray = incomeHistorySingleton.historyDict[account]!
        
        
    }
    
    private func setupStatisticsTableView(){
        statisticsTableView.delegate = self
        statisticsTableView.dataSource = self
        statisticsTableView.tableFooterView = UIView()
        statisticsTableView.backgroundColor = .clear
        
        let viewHeight = self.view.frame.height
        let topConstraint = NSLayoutConstraint(item: statisticsTableView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: viewHeight/3)
        statisticsTableView.addConstraint(topConstraint)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension IncomeStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statisticsTableView.dequeueReusableCell(withIdentifier: "IncomeStisticsTableViewCell", for: indexPath) as! IncomeStisticsTableViewCell
        cell.backgroundColor = .clear
        cell.dateLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.sumLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        cell.dateLbl.text = historyArray[indexPath.row].date
        cell.sumLbl.text = historyArray[indexPath.row].sum
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        statisticsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}
