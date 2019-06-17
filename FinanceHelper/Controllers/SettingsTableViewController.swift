//
//  SettingsTableViewController.swift
//  FinanceHelper
//
//  Created by Boris on 5/13/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var mainCurrencyLbl: UILabel!
    
    @IBOutlet weak var passwordLbl: UILabel!
    
    @IBOutlet weak var syncLbl: UILabel!
    
    @IBOutlet weak var reportLbl: UILabel!
    
    
    @IBOutlet weak var currencyBtn: UIButton!
    
    @IBOutlet weak var syncSwitcher: UISwitch!
    
    @IBOutlet weak var reportBtn: UIButton!
    
    
    @IBOutlet weak var mainCurrencyCell: UITableViewCell!
    
    @IBOutlet weak var passwordCell: UITableViewCell!
    
    @IBOutlet weak var syncCell: UITableViewCell!
    
    @IBOutlet weak var reportCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red:0.78, green:0.78, blue:0.78, alpha:1.0)]
        
        
        mainCurrencyCell.backgroundColor = .clear
        passwordCell.backgroundColor = .clear
        syncCell.backgroundColor = .clear
        reportCell.backgroundColor = .clear
        mainCurrencyLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        passwordLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        syncLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        reportLbl.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
