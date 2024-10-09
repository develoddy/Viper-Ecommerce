//
//  GaleriaModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct GaleriaModel: Codable {
    let id: Int?
    let imagen: String?
    let color: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imagen
        case color
    }
}
