//
//  ApiServiceEcommerce-auth.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

protocol APIServiceEcommerceAuthPrtocol {
    func fetchListAddress(userId: Int, token: String?, completion: @escaping (Result<SaleAddressResponse, Error>) -> Void)
}

class APIServiceEcommerceAuth: APIServiceEcommerceAuthPrtocol {
    
    func fetchListAddress(userId: Int, token: String?, completion: @escaping (Result<SaleAddressResponse, Error>) -> Void) {
        // Construir la URL base
        let urlString = "https://api.lujandev.com/api/address_client/list?user_id=\(userId)"
        
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
            //if let responseString = String(data: data, encoding: .utf8) {
            //    print("--- APIService: fetchWishlist Response Data: \(responseString)")
            //}
            
            do {
                // Decodificar la respuesta a WishlistResponse
                let saleAddressResponse = try JSONDecoder().decode(SaleAddressResponse.self, from: data)
                completion(.success(saleAddressResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
