//
//  DiscountCategorieModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct DiscountCategorieModel: Codable {
    let id: Int
    let discountId: Int
    let categoryId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case discountId = "discountId"
        case categoryId = "categoryId"
    }
}

