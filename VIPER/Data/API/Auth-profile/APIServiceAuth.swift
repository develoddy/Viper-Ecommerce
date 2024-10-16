//
//  APIServiceAuth.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation
protocol APIServiceAuthProtocol {
    func login(email: String?, password: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void)
    func fetchUserAuth() -> LoginResponse
    // CURRENT_USER_AUTHENTICATED
}


// MARK: APIServiceProtocol
class APIServiceAuth: APIServiceAuthProtocol {
    

    func fetchUserAuth() -> LoginResponse {
        var token = Token()
        return token.getUserToken()
    }
    
    
    
    
    func login(email: String?, password: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        BCApiRest.login(email: email, password: password) { result in
            completion(result)
        }
    }
    
}
