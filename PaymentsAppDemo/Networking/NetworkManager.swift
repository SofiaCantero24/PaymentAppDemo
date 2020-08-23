//
//  NetworkManager.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<PaymentsAPI> { get }

    func getPaymentMethods(success: @escaping NetworkSuccessBlock<[PaymentMethod]>,
                           failure: NetworkFailureBlock?)
    func getCardIssuers(paymentMethodId: String,
                        success: @escaping NetworkSuccessBlock<[CardIssuer]>,
                        failure: NetworkFailureBlock?)
    func getInstallments(paymentMethodId: String,
                         issuerId: String,
                         amount: Int,
                         success: @escaping NetworkSuccessBlock<[Installment]>,
                         failure: NetworkFailureBlock?)
}

class NetworkManager: BaseNetwork, Networkable {
    static let shared = NetworkManager()
    var provider = MoyaProvider<PaymentsAPI>()

    func getPaymentMethods(success: @escaping NetworkSuccessBlock<[PaymentMethod]>,
                           failure: NetworkFailureBlock?) {
        provider.request(.paymentMethods) { result in
            self.processResponse(result: result, success: success, failure: failure)
        }
    }
    
    func getCardIssuers(paymentMethodId: String,
                        success: @escaping NetworkSuccessBlock<[CardIssuer]>,
                        failure: NetworkFailureBlock?) {
        provider.request(.cardIssuers(paymentMethodId: paymentMethodId)) { result in
            self.processResponse(result: result, success: success, failure: failure)
        }
    }
    
    func getInstallments(paymentMethodId: String,
                         issuerId: String,
                         amount: Int,
                         success: @escaping NetworkSuccessBlock<[Installment]>,
                         failure: NetworkFailureBlock?) {
        provider.request(.installments(paymentMethodId: paymentMethodId,
                                       issuerId: issuerId,
                                       amount: amount)) { result in
            self.processResponse(result: result, success: success, failure: failure)
        }
    }
}
