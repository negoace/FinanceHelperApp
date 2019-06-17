//
//  ExpenseStatisticTableViewCell.swift
//  FinanceHelper
//
//  Created by Boris on 6/17/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

class ExpenseStatisticTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var sumLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
