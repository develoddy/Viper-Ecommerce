//
//  AddAddressProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

protocol AddAddressViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: AddAddressPresenterProtocol? { get set }
}

protocol AddAddressWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createAddAddressModule() -> UIViewController
}

protocol AddAddressPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: AddAddressViewProtocol? { get set }
    var interactor: AddAddressInteractorInputProtocol? { get set }
    var wireFrame: AddAddressWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol AddAddressInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol AddAddressInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: AddAddressInteractorOutputProtocol? { get set }
    var localDatamanager: AddAddressLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AddAddressRemoteDataManagerInputProtocol? { get set }
}

protocol AddAddressDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol AddAddressRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: AddAddressRemoteDataManagerOutputProtocol? { get set }
}

protocol AddAddressRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol AddAddressLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
