//
//  Account.swift
//  FinanceHelper
//
//  Created by Boris on 4/23/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import RealmSwift

class Account: Object {
   @objc dynamic var title: String = ""
   @objc dynamic var currency: String = "UAH"
   @objc dynamic var amountOfMoney: Float = 0
    var accountIncomeHistory:[IncomeHistory] = []
    var accountExpenseHistory:[ExpenseHistory] = []
    
}

