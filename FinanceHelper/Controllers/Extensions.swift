//
//  Extensions.swift
//  FinanceHelper
//
//  Created by Boris on 4/24/19.
//  Copyright © 2019 Boris. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupBackgroundImage(){
        let image = UIImage(named: "Background")
        let imageView = UIImageView(image: image)
        imageView.frame = self.view.bounds
        self.view.insertSubview(imageView, at: 0)
    }
}
