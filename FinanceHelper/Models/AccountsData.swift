//
//  AccountsData.swift
//  FinanceHelper
//
//  Created by Boris on 5/9/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation


class AccountsData {
    static var shared = AccountsData()
    var accounts: [Account] = []
    
    func printAccounts() {
        print(accounts)
    }
}
