//
//  PaymentsViewModel.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

class PaymentsViewModel {
    var paymentMethods = [PaymentMethod]()
    var cardIssuers = [CardIssuer]()
    var installments = [Installment]()

    private let amount: Float
    private let currentStep: PaymentsSteps = .paymentMethods
    private let networkManager: NetworkManager

    init(amount: Float, networkManager: NetworkManager = .shared) {
        self.amount = amount
        self.networkManager = networkManager
    }

    func numberOfRowsInCurrentStep() -> Int {
        switch currentStep {
        case .paymentMethods:
            return paymentMethods.count
        case .cardIssuers:
            return cardIssuers.count
        case .installments:
            return installments.count
        }
    }

    func getPaymentInfo(forIndex index: IndexPath) -> PaymentInfo? {
        switch currentStep {
        case .paymentMethods:
            guard let paymentMethodInfo = paymentMethods[safe: index.row] else { return nil }
            return PaymentInfo(imageURL: paymentMethodInfo.secureThumbnail,
                               name: paymentMethodInfo.name)
        case .cardIssuers:
            guard let cardIssuerInfo = cardIssuers[safe: index.row] else { return nil }
            return PaymentInfo(imageURL: cardIssuerInfo.secureThumbnail,
                               name: cardIssuerInfo.name)
        case .installments:
            guard let installmentsInfo = installments[safe: index.row] else { return nil }
            return PaymentInfo(imageURL: installmentsInfo.issuer.secureThumbnail,
                               name: installmentsInfo.payerCosts.first?.recommendedMessage ?? "")
        }
    }
}

// MARK: - Networking
extension PaymentsViewModel {
    func getPaymentMethods(completion: @escaping () -> Void) {
        networkManager.getPaymentMethods(success: { paymentMethods in
            self.paymentMethods = paymentMethods
            completion()
        }) { error in
            print("Payment methods service error: \(String(describing: error))")
            completion()
        }
    }

    func getCardIssuers(paymentMethodId: String, completion: @escaping () -> Void) {
        networkManager.getCardIssuers(paymentMethodId: paymentMethodId, success: { cardIssuers in
            self.cardIssuers = cardIssuers
            completion()
        }) { error in
            print("Card issuers service error: \(String(describing: error))")
            completion()
        }
    }

    func getInstallments(paymentMethodId: String, issuerId: String, completion: @escaping () -> Void) {
        networkManager.getInstallments(paymentMethodId: paymentMethodId,
                                       issuerId: issuerId,
                                       amount: amount, success: { installments in
            self.installments = installments
            completion()
        }) { error in
            print("Installments service error: \(String(describing: error))")
            completion()
        }
    }
}
