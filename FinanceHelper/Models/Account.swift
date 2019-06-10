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
   @objc dynamic var currency: String = "USD"
   @objc dynamic var amountOfMoney: Float = 0
    
//    init (title: String, currency: String){
//        self.title = title
//        self.currency = currency
//    }
//
//    init (title: String, currency: String, amountOfMoney: Float){
//        self.title = title
//        self.currency = currency
//        self.amountOfMoney = amountOfMoney
//    }
//
//    init (title: String) {
//        self.title = title
//    }
//
//    init() { }
//
    
}

