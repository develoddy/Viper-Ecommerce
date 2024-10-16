//
//  APIServiceWishlist.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

protocol APIServiceWishlistPrtocol {
    func fetchWishlist(userId: Int, timeNow: Int, token: String?, completion: @escaping (Result<WishlistResponse, Error>) -> Void)
}

class APIServiceWishlist: APIServiceWishlistPrtocol {
    
    // Fetch Wishlist
    func fetchWishlist(userId: Int, timeNow: Int, token: String?, completion: @escaping (Result<WishlistResponse, Error>) -> Void) {
        
        // Construir la URL base
        let urlString = "https://api.lujandev.com/api/wishlist/list?user_id=\(userId)&TIME_NOW=\(timeNow)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "URLInvalid", code: -1, userInfo: nil)))
            return
        }
        
        // Crear la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Si el token está disponible, agregarlo al header de la solicitud
        if let token = token {
            request.addValue(token, forHTTPHeaderField: "token")
        }
        
        // Iniciar la tarea de URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            /// Imprimir datos crudos para hacer prueba
            ///if let responseString = String(data: data, encoding: .utf8) {
            ///    print("--- APIService: fetchWishlist Response Data: \(responseString)")
            ///}
            do {
                // Decodificar la respuesta a WishlistResponse
                let wishlistResponse = try JSONDecoder().decode(WishlistResponse.self, from: data)
                completion(.success(wishlistResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
