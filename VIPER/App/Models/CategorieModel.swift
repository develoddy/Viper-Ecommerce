//
//  CategorieModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct CategorieModel: Codable {
    let id: Int?
    let title: String?
    let imagen: String?
    let state: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imagen
        case state
    }
}
