//
//  ListAddressInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class ListAddressInteractor: ListAddressInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: ListAddressInteractorOutputProtocol?
    var localDatamanager: ListAddressLocalDataManagerInputProtocol?
    var remoteDatamanager: ListAddressRemoteDataManagerInputProtocol?
    
    let authService: APIServiceAuthProtocol
    
    // MARK: - CONSTRUCTOR
    init(authService: APIServiceAuthProtocol = APIServiceAuth()) {
        self.authService = authService
    }
    
    func fetchSaleAddress() {
        if let userId = authService.fetchUserAuth()?.user?.id, let token = authService.fetchUserAuth()?.token {
            remoteDatamanager?.fetchSaleAddress(with: userId, with: token)
        } else {
            //presenter?.didFailToAuthenticateUser()
            print("Interactor: entra en Else")
        }
        
    }
}

extension ListAddressInteractor: ListAddressRemoteDataManagerOutputProtocol {
    func onListAddressRetrieved(with saleAddressResponse: SaleAddressResponse) {
        // Notificar al presenter con los datos de la ListAddress
        print("===> [Interactor] SaleAddressResponse Respuesta completa del API: \(saleAddressResponse)")
        presenter?.didRetrieveListAddress(saleAddressResponse)
    }

    
    func onError(_ error: Error) {
        // Notificar al presenter sobre el error
        presenter?.didFailToRetrieveListAddress(with: error)
    }
}
