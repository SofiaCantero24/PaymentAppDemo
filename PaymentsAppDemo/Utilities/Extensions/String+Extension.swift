//
//  String+Extension.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

extension String {
    var localizable: String {
        return NSLocalizedString(self, tableName: "LocalizablesES", value: "self", comment: "")
    }
}
