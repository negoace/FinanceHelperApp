//
//  ExpenseStatisticDict.swift
//  FinanceHelper
//
//  Created by Boris on 6/17/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import RealmSwift

class ExpenseStatisticDict: Object{
    @objc dynamic var key = ""
    dynamic var value = List<ExpenseHistory>()
    
}
