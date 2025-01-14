//
//  AddAddressPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class AddAddressPresenter  {
    
    // MARK: Properties
    weak var view: AddAddressViewProtocol?
    var interactor: AddAddressInteractorInputProtocol?
    var wireFrame: AddAddressWireFrameProtocol?
    
}

extension AddAddressPresenter: AddAddressPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension AddAddressPresenter: AddAddressInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
