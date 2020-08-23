//
//  PaymentMethod.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation

struct PaymentMethod: Codable {
    let id: String
    let name: String
    let secureThumbnail: String
    let minAllowedAmount: Int
    let maxAllowedAmount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case secureThumbnail = "secure_thumbnail"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        secureThumbnail = try container.decode(String.self, forKey: .secureThumbnail)
        minAllowedAmount = try container.decode(Int.self, forKey: .minAllowedAmount)
        maxAllowedAmount = try container.decode(Int.self, forKey: .maxAllowedAmount)
    }
}
