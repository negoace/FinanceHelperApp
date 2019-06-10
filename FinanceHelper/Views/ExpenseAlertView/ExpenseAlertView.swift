//
//  ExpenseAlertView.swift
//  FinanceHelper
//
//  Created by Boris on 4/30/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

protocol ExpenseAlertDelegate {
    func addBtnTapped()
    func cancelBtnTapped()
}

class ExpenseAlertView: UIView {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var firstLbl: UILabel!
    
    @IBOutlet weak var secondLbl: UILabel!
    
    @IBOutlet weak var thirdLbl: UILabel!
    
    @IBOutlet weak var firstLblTF: UITextField!
    
    @IBOutlet weak var secondLblTF: UITextField!
    
    @IBOutlet weak var thirdLblTF: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    var delegate: ExpenseAlertDelegate?
    
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        delegate?.addBtnTapped()
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        delegate?.cancelBtnTapped()
    }
}
