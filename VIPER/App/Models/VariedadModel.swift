//
//  VariedadModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

// Modelo de Variedad
struct Variedad: Codable {
    let id: Int?
    let valor: String
    let color: String
    let stock: Int
    let externalId: String
    let syncProductId: Int
    let name: String
    let synced: Bool
    let variantId: Int
    let mainCategoryId: Int
    let warehouseProductId: Int?
    let warehouseProductVariantId: Int?
    let retailPrice: String
    let sku: String
    let currency: String
    let productId: Int?

    // Relación con ProductVariants, File, y Option
    let productVariants: ProductVariants?
    let files: [FileModel]?
    let options: [OptionModel]?

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
        case mainCategoryId = "main_category_id"
        case warehouseProductId = "warehouse_product_id"
        case warehouseProductVariantId = "warehouse_product_variant_id"
        case retailPrice = "retail_price"
        case sku
        case currency
        case productId = "productId"
        case productVariants
        case files
        case options
    }
}

// Modelo de ProductVariants
struct ProductVariants: Codable {
    let varietyId: Int
    // Otros atributos de ProductVariants...
}

// Modelo de File
/*struct File: Codable {
    let varietyId: Int
    // Otros atributos de File...
}

// Modelo de Option
struct Option: Codable {
    let varietyId: Int
    // Otros atributos de Option...
}*/

// Ejemplo de inicialización de Variedad
let exampleVariedad = Variedad(
    id: 1,
    valor: "Red",
    color: "Rojo",
    stock: 50,
    externalId: "EXT12345",
    syncProductId: 1001,
    name: "Variedad de Producto",
    synced: true,
    variantId: 2001,
    mainCategoryId: 3001,
    warehouseProductId: nil,
    warehouseProductVariantId: nil,
    retailPrice: "29.99",
    sku: "SKU123",
    currency: "USD",
    productId: 1,
    productVariants: nil,
    files: nil,
    options: nil
)
