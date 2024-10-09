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
    
    /**
     ahora vuelvo!!!
     Service
     showLandingProduct(slug:string, discount_id:any=null) {
         // Inicia el loading
         this.loadingSubject.next(true);
         let LINK = "";
         if (discount_id) {
           LINK = "?_id="+discount_id;
         }
         let URL = URL_SERVICE+"home/show_landing_product/"+slug+LINK;
         //return this._http.get(URL);
         return this._http.get(URL).pipe(
           finalize(() => this.loadingSubject.next(false)) // Finaliza el loading cuando termina la llamada
         );
       }
     
     Componente.ts:
     private initLandingProduct() {
         this.productSubscription  = this._ecommerce_guestService.showLandingProduct(this.slug,this.discount_id).subscribe( ( resp:any ) => {
           
           this.product_selected   = resp.product;
           this.related_products   = resp.related_products;
           this.SALE_FLASH         = resp.SALE_FLASH;
           this.REVIEWS            = resp.REVIEWS;
           this.AVG_REVIEW         = resp.AVG_REVIEW;
           this.COUNT_REVIEW       = resp.COUNT_REVIEW;
     */
    
    // fetchProductDetails
    func fetchProductDetails(productId: Int, slug: String, discountId: Int?, completion: @escaping (Result<ProductDetailResponse, Error>) -> Void) {
  
        ///print("--Debug: APIService: Me llega productId, slug, discountId: \(productId) \(slug) \(String(describing: discountId))")
        
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
