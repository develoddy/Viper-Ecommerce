//
//  CartInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class CartInteractor: CartInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CartInteractorOutputProtocol?
    var localDatamanager: CartLocalDataManagerInputProtocol?
    var remoteDatamanager: CartRemoteDataManagerInputProtocol?
    
    
    let authService: APIServiceAuthProtocol
    
    // MARK: - CONSTRUCTOR
    init(authService: APIServiceAuthProtocol = APIServiceAuth()) {
        self.authService = authService
    }

    func checkUserAuthentication() {
        if let userId = authService.fetchUserAuth()?.user?.id {
            fetchCarts(with: userId)
        } else {
            presenter?.didFailToAuthenticateUser()
        }
    }
    
    func fetchCarts(with userId: Int) {
        remoteDatamanager?.fetchCarts(with: userId)
    }
}

extension CartInteractor: CartRemoteDataManagerOutputProtocol {
    
    // TODO: Implement use case methods
    func onCartsRetrieved(with cartResponse: CartsAPIResponse) {
        presenter?.didRetrieveCarts(cartResponse)
    }
    
    func onError(_ error: Error) {
        presenter?.didFailToRetrieveCarts(with: error)
    }
}
