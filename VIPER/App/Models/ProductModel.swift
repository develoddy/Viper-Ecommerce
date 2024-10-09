//
//  ProductModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct ProductModel: Codable {
    let id: Int?
    let idProduct: String?
    let title: String?
    let slug: String?
    let sku: String?
    let priceSoles: Float?
    let priceUsd: Float?
    let imagen: String?
    let state: Int?
    let stock: Int?
    let description: String?
    let resumen: String?
    let tags: [String] //String?
    let typeInventario: Int?
    
    // Relación con Categorie
    let category: CategorieModel? // Agrega la categoría asociada
    
    // Relación con Galeria
    let galeria: [GaleriaModel]? // Array de galerías asociadas

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case idProduct
        case title
        case slug
        case sku
        case priceSoles = "price_soles"
        case priceUsd = "price_usd"
        case imagen
        case state
        case stock
        case description
        case resumen
        case tags
        case typeInventario = "type_inventario"
        case category // Para la categoría
        case galeria // Para las galerías
    }
}
