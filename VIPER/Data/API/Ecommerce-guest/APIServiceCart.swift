//
//  APIServiceCart.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

protocol APIServiceCartProtocol {
    func fetchCarts(userId: Int, completion: @escaping (Result<CartsAPIResponse, Error>) -> Void)
}

class APIServiceCart: APIServiceCartProtocol {
    
    // Fetch Cart
    func fetchCarts(userId: Int, completion: @escaping (Result<CartsAPIResponse, Error>) -> Void) {
        
        // Obtener token de autenticación (por ejemplo, desde el servicio de autenticación)
        let authService = APIServiceAuth()
        let token = authService.fetchUserAuth().token
        
        // Construir la URL base
        let urlString = "https://api.lujandev.com/api/cart/list?user_id=\(userId)"
        
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
            
            // Imprimir datos crudos para pruebas (opcional)
            // if let responseString = String(data: data, encoding: .utf8) {
            //     print("--- APIService: fetchCarts Response Data: \(responseString)")
            // }
            
            do {
                // Decodificar la respuesta a CartResponse
                let cartResponse = try JSONDecoder().decode(CartsAPIResponse.self, from: data)
                completion(.success(cartResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
