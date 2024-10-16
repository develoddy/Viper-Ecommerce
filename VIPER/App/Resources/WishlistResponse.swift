//
//  WishlistResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

struct WishlistResponse: Codable {
    let wishlists: [WishlistItem]
    let flashSale: DiscountModel?
    let campaignProducts: [ProductModel]
    
    enum CodingKeys: String, CodingKey {
        case wishlists
        case flashSale = "FlashSale"
        case campaignProducts = "campaign_products"
    }
}

struct WishlistItem: Codable {
    let id: Int
    let userId: Int
    let product: ProductModelResponse

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "user"
        case product
    }
}

// Modelo de ProductResponse
struct ProductModelResponse: Codable {
    let id: Int
    let title: String
    let sku: String
    let slug: String
    let imagen: String?
    let category: CategorieModel?
    let priceSoles: Double
    let priceUsd: Double
    let stock: Int
    let description: String
    let resumen: String
    let tags: [String]
    let typeInventario: Int
    let state: Int
    let variedades: [Variedad]
    let imagenTwo: String
    let galerias: [GaleriaModel]
    let avgReview: Double
    let countReview: Int
    let campaingDiscount: DiscountModel?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case sku
        case slug
        case imagen
        case category = "categorie"
        case priceSoles = "price_soles"
        case priceUsd = "price_usd"
        case stock
        case description
        case resumen
        case tags
        case typeInventario = "type_inventario"
        case state
        case variedades
        case imagenTwo = "imagen_two"
        case galerias
        case avgReview = "avg_review"
        case countReview = "count_review"
        case campaingDiscount = "campaing_discount"
    }
}
