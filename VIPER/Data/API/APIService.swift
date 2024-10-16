//
//  APIService.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//
// // Interfaz general para la autenticación, que delega en BCApiRest.

import Foundation

// MARK: APIServiceProtocol
class APIService: APIServiceProtocol {
    
    // Login
    func login(email: String?, password: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        BCApiRest.login(email: email, password: password) { result in
            completion(result)
        }
    }
    
    // Fetch List
    func fetchList(timeNow: Int, token: String?, completion: @escaping (Result<HomeListResponse, Error>) -> Void) {
        let url = URL(string: "https://api.lujandev.com/api/home/list?TIME_NOW=\(timeNow)")! // Asegúrate de usar la URL correcta
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let listResponse = try JSONDecoder().decode(HomeListResponse.self, from: data)
                //print("====> Debbug en APIService metodo FetchList Success: \(listResponse)")
                completion(.success(listResponse))
            } catch {
                print("====> Debbug en APIService metodo FetchList Error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // fetchProductDetails
    func fetchProductDetails(productId: Int, slug: String, discountId: Int?, completion: @escaping (Result<ProductDetailResponse, Error>) -> Void) {
        
        // Construir la URL
        var urlString = "https://api.lujandev.com/api/home/show_landing_product/\(slug)"
        if let discountId = discountId {
            urlString += "?_id=\(discountId)"
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "URLInvalid", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let productResponse = try JSONDecoder().decode(ProductDetailResponse.self, from: data)
                completion(.success(productResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Fetch Wishlist
    func fetchWishlist(userId: Int, timeNow: Int, token: String?, completion: @escaping (Result<WishlistResponse, Error>) -> Void) {
        
        // Construir la URL base
        let urlString = "https://api.lujandev.com/api/wishlist/list?user_id=\(userId)&TIME_NOW=\(timeNow)"
        print("--- APIService: fetchWishlist urlString ==== \(urlString)")
        
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
    
    /**func fetchList(timeNow: Int, token: String?, completion: @escaping (Result<HomeListResponse, Error>) -> Void) {
        // Suponiendo que tienes el token almacenado en algún lugar
        guard let token = token else {
            return
        }//"tu_token_aqui" // Cambia esto por el método que utilizas para obtener el token
        BCApiRest.fetchList(timeNow: timeNow, token: token) { result in
            completion(result)
        }
    }*/
}
