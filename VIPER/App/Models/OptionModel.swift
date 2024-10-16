//
//  OptionModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

// Modelo de Option utilizando Codable
struct OptionModel: Codable {
    let id: Int?
    let idOption: String
    let value: [String] // Usamos un array de strings para el campo JSON
    // Otras propiedades como timestamps si fueran necesarias

    enum CodingKeys: String, CodingKey {
        case id
        case idOption = "idOption"
        case value
    }
}

// Ejemplo de inicialización del modelo Option
let exampleOption = OptionModel(
    id: 1,
    idOption: "opt123",
    value: ["Option1", "Option2", "Option3"] // El valor JSON se mapea a un array de strings
)
