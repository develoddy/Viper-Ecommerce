//
//  WishlistInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation

class WishlistInteractor: WishlistInteractorInputProtocol {
   
    // MARK: - Properties
    weak var presenter: WishlistInteractorOutputProtocol?
    var localDatamanager: WishlistLocalDataManagerInputProtocol?
    var remoteDatamanager: WishlistRemoteDataManagerInputProtocol?
    
    let authService: APIServiceAuthProtocol
    
    // MARK: - CONSTRUCTOR
    init(authService: APIServiceAuthProtocol = APIServiceAuth()) {
        self.authService = authService
    }
    
    func checkUserAuthentication() {
        if let userId = authService.fetchUserAuth()?.user?.id, let token = authService.fetchUserAuth()?.token {
            fetchWishlists(with: userId, with: token)
        } else {
            presenter?.didFailToAuthenticateUser()
        }
    }
    
    func fetchWishlists(with userId: Int, with token: String) {
        remoteDatamanager?.fetchWishlists(with: userId, with: token)
    }
}

extension WishlistInteractor: WishlistRemoteDataManagerOutputProtocol {
    
    // TODO: Implement use case methods
    func onWishlistRetrieved(with wishlistResponse: WishlistResponse) {
        // Notificar al presenter con los datos de la wishlist
        presenter?.didRetrieveWishlist(wishlistResponse)
    }
    
    func onError(_ error: Error) {
        // Notificar al presenter sobre el error
        presenter?.didFailToRetrieveWishlist(with: error)
    }
}
