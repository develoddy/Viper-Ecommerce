//
//  WishlistInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation

class WishlistInteractor: WishlistInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: WishlistInteractorOutputProtocol?
    var localDatamanager: WishlistLocalDataManagerInputProtocol?
    var remoteDatamanager: WishlistRemoteDataManagerInputProtocol?

}

extension WishlistInteractor: WishlistRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
