//
//  CartPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class CartPresenter: CartPresenterProtocol  {
    
    // MARK: Properties
    weak var view: CartViewProtocol?
    var interactor: CartInteractorInputProtocol?
    var wireFrame: CartWireFrameProtocol?
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

// MARK: - CartInteractorOutputProtocol
extension CartPresenter: CartInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
