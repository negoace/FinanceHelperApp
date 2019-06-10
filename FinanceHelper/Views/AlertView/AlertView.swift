//
//  AlertView.swift
//  FinanceHelper
//
//  Created by Boris on 4/23/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import UIKit

protocol AlertDelegate {
    func addBtnPressed()
    func cancelBtnPressed()
}


class AlertView: UIView {
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var firstLbl: UILabel!
    
    @IBOutlet weak var secondLbl: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var firstLblTF: UITextField!
    
    @IBOutlet weak var secondLblTF: UITextField!
    
    var delegate: AlertDelegate?
    
    
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        delegate?.addBtnPressed()
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        delegate?.cancelBtnPressed()
    }
    
    func set(title: String, firstLbl: String, secondLbl: String) {
        self.titleLbl.text = title
        self.firstLbl.text = firstLbl
        self.secondLbl.text = secondLbl
    }
    
}
