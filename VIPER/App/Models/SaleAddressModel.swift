//
//  SaleAddressModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct SaleAddressModel: Codable {
    let id: Int
    let name: String
    let surname: String
    let pais: String
    let address: String
    let zipcode: String? // Opcional si no siempre está presente
    let poblacion: String
    let ciudad: String
    let email: String
    let phone: String
    let referencia: String?
    let nota: String?
    let birthday: String? // Opcional, según el JSON proporcionado
    let createdAt: String
    let updatedAt: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case pais
        case address
        case zipcode
        case poblacion
        case ciudad
        case email
        case phone
        case referencia
        case nota
        case birthday
        case createdAt
        case updatedAt
        case userId
    }
}

