//
//  AmountViewModel.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class AmountViewModel {
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        return formatter
    }()

    /**
     Change given string to a currency format
     - parameter string: input string
     - returns: formatted string
     */
    func toCurrencyFormat(_ string: String) -> String {
        let number = NSNumber(value: stringToFloat(string))
        guard number != 0 as NSNumber else { return "" }
    
        return numberFormatter.string(from: number)!
    }

    /**
     Change string (formatted or not) to its Float value
     - parameter string: input string
     - returns: float value
     */
    func stringToFloat(_ string: String) -> Float {
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        let nonFormattedString = regex.stringByReplacingMatches(in: string,
                                                                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                                range: NSMakeRange(0, string.count),
                                                                withTemplate: "")

        return (nonFormattedString as NSString).floatValue / 100
    }
}
