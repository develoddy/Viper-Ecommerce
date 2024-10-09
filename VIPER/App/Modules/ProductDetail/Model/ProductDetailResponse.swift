//
//  ProductResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 9/10/24.
//

import Foundation

// Modelo de Respuesta de Producto
struct ProductDetailResponse: Codable {
    let product: ProductModel
    let related_products: [ProductModel]
    let SALE_FLASH: String?
    let REVIEWS: [ReviewModel]
    let AVG_REVIEW: Double
    let COUNT_REVIEW: Int
}
