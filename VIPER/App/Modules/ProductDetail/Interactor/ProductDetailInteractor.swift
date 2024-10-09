//
//  ProductDetailInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class ProductDetailInteractor: ProductDetailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ProductDetailInteractorOutputProtocol?
    var localDatamanager: ProductDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: ProductDetailRemoteDataManagerInputProtocol?

}

extension ProductDetailInteractor: ProductDetailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
