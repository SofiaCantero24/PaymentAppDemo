//
//  UIImageView+Extension.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func requestImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
