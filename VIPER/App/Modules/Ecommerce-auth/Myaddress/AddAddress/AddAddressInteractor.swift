//
//  AddAddressInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class AddAddressInteractor: AddAddressInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: AddAddressInteractorOutputProtocol?
    var localDatamanager: AddAddressLocalDataManagerInputProtocol?
    var remoteDatamanager: AddAddressRemoteDataManagerInputProtocol?

}

extension AddAddressInteractor: AddAddressRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
