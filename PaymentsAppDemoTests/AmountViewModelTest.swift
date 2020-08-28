//
//  AmountViewModelTest.swift
//  PaymentsAppDemoTests
//
//  Created by Laura Sofia Cantero Hernandez on 8/27/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import XCTest
@testable import PaymentsAppDemo

class AmountViewModelTest: XCTestCase {
    let amountViewModel = AmountViewModel()

    func testCurrencyFormat() {
        XCTAssertEqual(amountViewModel.toCurrencyFormat("34000"), "$340.00")
        XCTAssertEqual(amountViewModel.toCurrencyFormat("3400000"), "$34,000.00")
    }

    func testStringToFloat() {
        XCTAssertEqual(amountViewModel.stringToFloat("$340.00"), 340.0)
        XCTAssertEqual(amountViewModel.stringToFloat("$34,000.00"), 34000.0)
        XCTAssertEqual(amountViewModel.stringToFloat("34000"), 340.0)
        XCTAssertEqual(amountViewModel.stringToFloat("3400000"), 34000.0)
    }
}
