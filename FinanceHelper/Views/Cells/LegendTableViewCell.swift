//
//  LegendTableViewCell.swift
//  FinanceHelper
//
//  Created by Boris on 5/2/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

class LegendTableViewCell: UITableViewCell {

    @IBOutlet weak var colorOfElement: UIView!
    
    @IBOutlet weak var nameOfAccountLbl: UILabel!
    
    @IBOutlet weak var valueOfAccountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
