//
//  ProfileInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?
    
    func logout() {
        // Aquí va la lógica de cierre de sesión (p. ej., eliminar tokens)
        // Una vez completado, informamos al presenter
        //presenter?.didLogout()
    }

}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
