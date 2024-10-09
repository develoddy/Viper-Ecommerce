//
//  DiscountProductModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct DiscountProductModel: Codable {
    let id: Int
    let discountId: Int
    let productId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case discountId = "discountId"
        case productId = "productId"
    }
}

