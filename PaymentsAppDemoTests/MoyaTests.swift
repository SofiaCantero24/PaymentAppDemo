//
//  ModelsTests.swift
//  PaymentsAppDemoTests
//
//  Created by Laura Sofia Cantero Hernandez on 8/27/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import XCTest
@testable import Moya
@testable import PaymentsAppDemo

class ModelsTests: XCTestCase {
    let stubbingProvider = MoyaProvider<PaymentsAPI>(stubClosure: MoyaProvider.immediatelyStub)

    func testPaymentMethodsService() {
       let expectation = self.expectation(description: "Payment methods service")
        _ = stubbingProvider.request(.paymentMethods) { response in
            switch response {
            case .success(_):
                 expectation.fulfill()
            case .failure(_):
                XCTFail("Test should sucess")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCardIssuersService() {
       let expectation = self.expectation(description: "Card issuers service")
        _ = stubbingProvider.request(.cardIssuers(paymentMethodId: "visa")) { response in
            switch response {
            case .success(_):
                 expectation.fulfill()
            case .failure(_):
                XCTFail("Test should sucess")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testInstallmentsService() {
       let expectation = self.expectation(description: "Installments service")
        _ = stubbingProvider.request(.installments(paymentMethodId: "visa",
                                                   issuerId: "1087",
                                                   amount: 6000)) { response in
            switch response {
            case .success(_):
                 expectation.fulfill()
            case .failure(_):
                XCTFail("Test should sucess")
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
}
