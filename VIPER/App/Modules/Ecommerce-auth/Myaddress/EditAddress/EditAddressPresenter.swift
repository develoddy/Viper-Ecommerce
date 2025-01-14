//
//  EditAddressPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class EditAddressPresenter  {
    
    // MARK: Properties
    weak var view: EditAddressViewProtocol?
    var interactor: EditAddressInteractorInputProtocol?
    var wireFrame: EditAddressWireFrameProtocol?
    
}

extension EditAddressPresenter: EditAddressPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension EditAddressPresenter: EditAddressInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
