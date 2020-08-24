//
//  Array+Extension.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return index < count ? self[index] : nil
    }
}
