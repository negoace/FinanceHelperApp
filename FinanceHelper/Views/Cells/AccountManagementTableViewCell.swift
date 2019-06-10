//
//  AccountManagementTableViewCell.swift
//  FinanceHelper
//
//  Created by Boris on 4/23/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

class AccountManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var accountTitleLbl: UILabel!
    
    @IBOutlet weak var amountOfMoneyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
