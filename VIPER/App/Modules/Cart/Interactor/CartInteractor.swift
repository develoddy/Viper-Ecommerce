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

}

extension CartInteractor: CartRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
