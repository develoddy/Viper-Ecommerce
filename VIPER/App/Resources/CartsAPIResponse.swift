//
//  CartResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

struct CartsAPIResponse: Codable {
    let carts: [CartAPIResponse]
}


// Modelo principal del carrito (Cart)
struct CartAPIResponse: Codable {
    let id: Int?
    let userId: Int?
    let product: ProductAPIModel
    let typeDiscount: String?
    let discount: Float?
    let cantidad: Int?
    let variedad: VariedadAPIModel?
    let codeCupon: String?
    let codeDiscount: String?
    let priceUnitario: String?
    let subtotal: String?
    let total: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId = "user"
        case product
        case typeDiscount = "type_discount"
        case discount
        case cantidad
        case variedad
        case codeCupon = "code_cupon"
        case codeDiscount = "code_discount"
        case priceUnitario = "price_unitario"
        case subtotal
        case total
    }
}

struct ProductAPIModel: Codable {
    let id: Int?
    let title: String?
    let slug: String?
    let sku: String?
    let imagen: String?
    let priceSoles: Float?
    let priceUsd: Float?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case slug
        case sku
        case imagen
        case priceSoles = "price_soles"
        case priceUsd = "price_usd"
    }
}


struct VariedadAPIModel: Codable {
    let id: Int?
    let valor: String
    let color: String
    let stock: Int
    let externalId: String
    let syncProductId: Int
    let name: String
    let synced: Bool
    let variantId: Int
    let retailPrice: String
    let sku: String
    let currency: String
    let productId: Int?
    let files: [FileModel]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case valor
        case color
        case stock
        case externalId = "external_id"
        case syncProductId = "sync_product_id"
        case name
        case synced
        case variantId = "variant_id"
        case retailPrice = "retail_price"
        case sku
        case currency
        case productId = "productId"
        case files
    }
}
