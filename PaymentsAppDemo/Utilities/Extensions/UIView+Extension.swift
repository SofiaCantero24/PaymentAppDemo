//
//  UIView+Extension.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func loadFirstSubViewFromNib() -> UIView {
        return UINib(nibName: String(describing: self),
                     bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
