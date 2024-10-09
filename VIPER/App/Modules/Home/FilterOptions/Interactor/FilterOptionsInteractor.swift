//
//  FilterOptionsInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class FilterOptionsInteractor: FilterOptionsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: FilterOptionsInteractorOutputProtocol?
    var localDatamanager: FilterOptionsLocalDataManagerInputProtocol?
    var remoteDatamanager: FilterOptionsRemoteDataManagerInputProtocol?

}

extension FilterOptionsInteractor: FilterOptionsRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
