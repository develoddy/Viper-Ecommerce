//
//  UserModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

// Modelo para el usuario
struct UserModel: Codable {
    let id: Int?
    let rol: String
    let name: String
    let surname: String?
    let email: String
    let password: String
    let avatar: String?
    let state: Int?
    let phone: String?
    let birthday: String?
    let zipcode: String?
    
    // Initializer para facilitar la creación de instancias
    init(id: Int? = nil, rol: String, name: String, surname: String? = nil,
         email: String, password: String, avatar: String? = nil,
         state: Int? = 1, phone: String? = nil, birthday: String? = nil,
         zipcode: String? = nil) {
        self.id = id
        self.rol = rol
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.avatar = avatar
        self.state = state
        self.phone = phone
        self.birthday = birthday
        self.zipcode = zipcode
    }
}

// Enum para manejar errores relacionados con el usuario
enum UserError: Error {
    case userNotFound
    case invalidCredentials
    case unknownError(String)
}
