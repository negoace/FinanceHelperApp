//
//  Nib.swift
//  FinanceHelper
//
//  Created by Boris on 4/23/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
