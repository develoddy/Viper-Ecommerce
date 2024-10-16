//
//  WishlistModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation


// Definimos el modelo Wishlist utilizando Codable
struct Wishlist: Codable {
    let id: Int?
    let typeDiscount: Int?
    let discount: Float?
    let cantidad: Int
    let codeCupon: String?
    let codeDiscount: String?
    let priceUnitario: String
    let subtotal: String
    let total: String
    let userId: Int?
    let productId: Int?
    let variedadId: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case typeDiscount = "type_discount"
        case discount
        case cantidad
        case codeCupon = "code_cupon"
        case codeDiscount = "code_discount"
        case priceUnitario = "price_unitario"
        case subtotal
        case total
        case userId = "userId"
        case productId = "productId"
        case variedadId = "variedadId"
    }
}

// Ejemplo de cómo inicializar el modelo Wishlist
let exampleWishlist = Wishlist(
    id: 1,
    typeDiscount: 1,
    discount: 0.0,
    cantidad: 2,
    codeCupon: "DESC20",
    codeDiscount: "DISCOUNT20",
    priceUnitario: "100.00",
    subtotal: "200.00",
    total: "180.00",
    userId: 1,
    productId: 1,
    variedadId: nil
)
