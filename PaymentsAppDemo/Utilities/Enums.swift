//
//  Enums.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/27/20.
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
