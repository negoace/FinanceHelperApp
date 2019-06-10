//
//  AccountRealm.swift
//  FinanceHelper
//
//  Created by Boris on 6/5/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import RealmSwift

class AccountRealm: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var currency: String = ""
    @objc dynamic var amountOfMoney: Float = 0
}
