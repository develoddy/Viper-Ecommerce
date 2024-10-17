//
//  APIServiceEcommerce-guest.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

protocol  APIServiceEcommerceGuestPrtocol {
    func fetchList(timeNow: Int, completion: @escaping (Result<HomeListResponse, Error>) -> Void)
    func fetchProductDetails(productId: Int, slug: String, discountId: Int?, completion: @escaping (Result<ProductDetailResponse, Error>) -> Void)
}

class APIServiceEcommerceGuest: APIServiceEcommerceGuestPrtocol {
    
    // Fetch List
    func fetchList(timeNow: Int, completion: @escaping (Result<HomeListResponse, Error>) -> Void) {
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
}
