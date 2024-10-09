//
//  WelcomeInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//  
//

import Foundation

class WelcomeInteractor: WelcomeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: WelcomeInteractorOutputProtocol?
    var localDatamanager: WelcomeLocalDataManagerInputProtocol?
    var remoteDatamanager: WelcomeRemoteDataManagerInputProtocol?

}

extension WelcomeInteractor: WelcomeRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
