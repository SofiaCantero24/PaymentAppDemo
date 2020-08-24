//
//  PaymentsViewModel.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

enum PaymentsSteps: Int {
    case paymentMethods
    case cardIssuers
    case installments

    var title: String {
        switch self {
        case .paymentMethods:
            return Localizables.paymentMethodsTitle
        case .cardIssuers:
            return Localizables.cardIssuersTitle
        case .installments:
            return Localizables.installmentsTitle
        }
    }
}

class PaymentsViewModel {
    var paymentMethods = [PaymentMethod]()
    var cardIssuers = [CardIssuer]()
    var installments = [Installment]()

    private let amount: Float
    private let networkManager: NetworkManager

    private var currentStep: PaymentsSteps = .paymentMethods
    private var paymentMethodId = ""
    private var cardIssuerId = ""

    var currentStepTitle: String {
        return currentStep.title
    }

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

    func didSelectRowAt(index: IndexPath, completion: @escaping () -> Void) {
        switch currentStep {
        case .paymentMethods:
            guard let paymentMethodId = paymentMethods[safe: index.row]?.id else { return }
            self.paymentMethodId = paymentMethodId
            getCardIssuers(paymentMethodId: paymentMethodId) {
                self.currentStep = .cardIssuers
                completion()
            }
        case .cardIssuers:
            guard let cardIssuerId = cardIssuers[safe: index.row]?.id else { return }
            self.cardIssuerId = cardIssuerId
            getInstallments(paymentMethodId: paymentMethodId, issuerId: cardIssuerId) {
                self.currentStep = .installments
                completion()
            }
        case .installments:
            //TODO - success view
            break
        }
    }

    /**
     Update currentStep value with the previous one
     - returns: true if there is a previous step, otherwise false
     */
    func previousStep() -> Bool {
        switch currentStep {
        case .paymentMethods:
            return false
        case .cardIssuers:
            currentStep = .paymentMethods
            return true
        case .installments:
            currentStep = .cardIssuers
            return true
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
