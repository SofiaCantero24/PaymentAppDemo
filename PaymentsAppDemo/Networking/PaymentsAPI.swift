//
//  NetworkClient.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/22/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import Moya

public enum PaymentsAPI {
    private static let publicKey = "TEST-43bd6a88-41c4-46b1-9fb5-c2cafe0929c7"

    case paymentMethods
    case cardIssuers(paymentMethodId: String)
    case installments(paymentMethodId: String, issuerId: String, amount: Float)
}

extension PaymentsAPI: TargetType {
    public var baseURL: URL {
      return URL(string: "https://api.mercadopago.com/v1")!
    }

    public var path: String {
        switch self {
        case .paymentMethods:
            return "/payment_methods"
        case .cardIssuers:
            return "/payment_methods/card_issuers"
        case .installments:
            return "/payment_methods/installments"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .paymentMethods:
            return ["public_key": PaymentsAPI.publicKey]
        case .cardIssuers(let paymentMethodId):
            return ["public_key": PaymentsAPI.publicKey,
                    "payment_method_id": paymentMethodId]
        case .installments(let paymentMethodId, let issuerId, let amount):
            return ["public_key": PaymentsAPI.publicKey,
                    "payment_method_id": paymentMethodId,
                    "issuer.id": issuerId,
                    "amount": amount]
        }
    }

    public var method: Moya.Method {
      return .get
    }

    public var sampleData: Data {
      return Data()
    }

    public var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    public var headers: [String: String]? {
      return ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
      return .successCodes
    }
}
