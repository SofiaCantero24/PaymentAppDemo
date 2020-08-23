//
//  Installment.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

struct Installment: Codable {
    let issuer: CardIssuer
    let payerCosts: [PayerCosts]

    enum CodingKeys: String, CodingKey {
        case issuer
        case payerCosts = "payer_costs"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        issuer = try container.decode(CardIssuer.self, forKey: .issuer)
        payerCosts = try container.decode([PayerCosts].self, forKey: .payerCosts)
    }
}

struct PayerCosts: Codable {
    let recommendedMessage: String

    enum CodingKeys: String, CodingKey {
        case recommendedMessage = "recommended_message"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        recommendedMessage = try container.decode(String.self, forKey: .recommendedMessage)
    }
}
