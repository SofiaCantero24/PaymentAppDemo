//
//  UIViewController+Extension.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
}
