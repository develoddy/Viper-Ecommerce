//
//  EditAddressInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class EditAddressInteractor: EditAddressInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: EditAddressInteractorOutputProtocol?
    var localDatamanager: EditAddressLocalDataManagerInputProtocol?
    var remoteDatamanager: EditAddressRemoteDataManagerInputProtocol?

}

extension EditAddressInteractor: EditAddressRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
