//
//  ExpenseHistory.swift
//  FinanceHelper
//
//  Created by Boris on 6/17/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import RealmSwift

class ExpenseHistory: Object {
    static let shared = ExpenseHistory()
    var historyDict: [String:[ExpenseHistory]] = [:]
    @objc dynamic var expense = ""
    @objc dynamic var sum = ""
    @objc dynamic var date = ""
}
