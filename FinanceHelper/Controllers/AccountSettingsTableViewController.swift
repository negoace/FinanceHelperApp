//
//  AccountSettingsTableViewController.swift
//  FinanceHelper
//
//  Created by Boris on 5/9/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

class AccountSettingsTableViewController: UITableViewController {

    @IBOutlet weak var currencyLbl: UILabel!
    
    @IBOutlet weak var incomeStatisticsLbl: UILabel!
    
    @IBOutlet weak var expenseStatisticsLbl: UILabel!
    
    @IBOutlet weak var currencyCell: UITableViewCell!
    
    @IBOutlet weak var incomeStatCell: UITableViewCell!
    
    @IBOutlet weak var expenseStatCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        
        
        currencyCell.backgroundColor = .clear
        incomeStatCell.backgroundColor = .clear
        expenseStatCell.backgroundColor = .clear
        currencyLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        incomeStatisticsLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        expenseStatisticsLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IncomeStatisticsViewController"{
            let nextVC = segue.destination as! IncomeStatisticsViewController
            nextVC.account = self.navigationItem.title!
        }
        
        if segue.identifier == "ExpenseViewController" {
            let nextVC = segue.destination as! ExpenseViewController
            nextVC.account = self.navigationItem.title!
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
