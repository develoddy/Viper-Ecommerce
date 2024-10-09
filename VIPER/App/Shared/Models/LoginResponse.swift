//
//  LoginResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation


// MARK: - ResponseTokenBE
struct LoginResponse: Codable {
    let token: String?
    let user: User?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let surname: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, surname, avatar
    }
}

// MARK: - USER_FRONTED Wrapper
struct UserFrontedResponse: Codable {
    let userFronted: LoginResponse

    enum CodingKeys: String, CodingKey {
        case userFronted = "USER_FRONTED"
    }
}
