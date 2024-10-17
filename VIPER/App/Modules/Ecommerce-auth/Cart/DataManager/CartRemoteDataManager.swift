//
//  CartRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class CartRemoteDataManager:CartRemoteDataManagerInputProtocol {

    var remoteRequestHandler: CartRemoteDataManagerOutputProtocol?
    
    let apiService: APIServiceCartProtocol
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceCartProtocol = APIServiceCart()) {
        self.apiService = apiService
    }
        
    // Buscar productos en el carrito en la base de datos
    func fetchCarts(with userId: Int) {
        
        // Llama a la función fetchCarts en el apiService
        apiService.fetchCarts(userId: userId) { result in
            switch result {
            case .success(let cartResponse): 
                ///print("---- CartRemoteDataManager API COMPLETA CART: \(cartResponse)")
                // Notificar al interactor con los datos obtenidos
                self.remoteRequestHandler?.onCartsRetrieved(with: cartResponse)
                
            case .failure(let error):
                // Maneja el error de manera adecuada
                print("Error fetching carts: \(error.localizedDescription)")
                // Notifica al interactor sobre el error
                self.remoteRequestHandler?.onError(error)
            }
        }
    }
}
