//
//  IncomeHistory.swift
//  FinanceHelper
//
//  Created by Boris on 6/17/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import RealmSwift

class IncomeHistory: Object {
    static let shared = IncomeHistory()
    var historyArray: [IncomeHistory] = []
    var historyDict:[String:[IncomeHistory]] = [:]
    @objc dynamic var date: String = ""
    @objc dynamic var sum: String = ""
}
