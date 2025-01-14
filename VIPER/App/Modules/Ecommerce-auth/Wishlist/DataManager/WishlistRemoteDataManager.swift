//
//  WishlistRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation

class WishlistRemoteDataManager:WishlistRemoteDataManagerInputProtocol {

    var remoteRequestHandler: WishlistRemoteDataManagerOutputProtocol?
    
    // Lista que contendrá los datos obtenidos
    //var wishlistItems: [WishlistResponse] = []
    
    // We defined the FakeAPIServiceProtocol in the APIService.swift file.
    let apiService: APIServiceWishlistPrtocol
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceWishlistPrtocol = APIServiceWishlist()) {
        self.apiService = apiService
    }
    
    // Método para obtener la wishlist
    func fetchWishlists(with userId: Int, with token: String) {
       
       // Define el tiempo actual
       let timeNow = Int(Date().timeIntervalSince1970)
       
       // Llama a la función fetchWishlist en el apiService
       apiService.fetchWishlist(userId: userId, timeNow: timeNow, token: token) { result in
           switch result {
           case .success(let wishlistResponse):
               ///print("===> WhislistRemote Respuesta completa del API: \(wishlistResponse)")
               // Notificar al interactor con los datos obtenidos
               //self?.remoteRequestHandler?.onWishlistRetrieved(wishlistResponse)
               self.remoteRequestHandler?.onWishlistRetrieved(with: wishlistResponse)
               
           case .failure(let error):
               print("Error fetching wishlist: \(error.localizedDescription)")
               // Notifica al interactor sobre el error
               self.remoteRequestHandler?.onError(error)
           }
       }
    }
}
