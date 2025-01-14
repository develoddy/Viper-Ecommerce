//
//  ListAddressRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class ListAddressRemoteDataManager:ListAddressRemoteDataManagerInputProtocol {
   
    var remoteRequestHandler: ListAddressRemoteDataManagerOutputProtocol?
    let apiService: APIServiceEcommerceAuthPrtocol
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceEcommerceAuthPrtocol = APIServiceEcommerceAuth()) {
        self.apiService = apiService
    }
    
    func fetchSaleAddress(with userId: Int, with token: String) {
        
        // Llama a la función fetchWishlist en el apiService
        apiService.fetchListAddress(userId: userId, token: token) { result in
            switch result {
            case .success(let saleAddressResponse):
                ///print("===> SaleAddressResponse Respuesta completa del API: \(saleAddressResponse)")
                self.remoteRequestHandler?.onListAddressRetrieved(with: saleAddressResponse)
                //self.remoteRequestHandler?.onWishlistRetrieved(with: wishlistResponse)
                
            case .failure(let error):
                print("Error fetching wishlist: \(error.localizedDescription)")
                self.remoteRequestHandler?.onError(error)
            }
        }
        
    }
}
