//
//  ReviewModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation


struct ReviewModel: Codable {
    let id: Int
    let cantidad: Int
    let title: String
    let description: String
    let productId: Int
    let saleDetailId: Int
    let userId: Int
    let createdAt: Date
    let updatedAt: Date

    // Inicializador
    init(id: Int, cantidad: Int, title: String, description: String, productId: Int, saleDetailId: Int, userId: Int, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.cantidad = cantidad
        self.title = title
        self.description = description
        self.productId = productId
        self.saleDetailId = saleDetailId
        self.userId = userId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
