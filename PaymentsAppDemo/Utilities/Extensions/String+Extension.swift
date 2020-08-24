//
//  String+Extension.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

extension String {
    var currencyInputFloatValue: Float {
        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                          range: NSMakeRange(0, count),
                                                          withTemplate: "")

        return (amountWithPrefix as NSString).floatValue / 100
    }

    var currencyInputFormatting: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        let number = NSNumber(value: currencyInputFloatValue)

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else { return "" }

        return formatter.string(from: number)!
    }

    var localizable: String {
        return NSLocalizedString(self, tableName: "LocalizablesES", value: "self", comment: "")
    }
}
