//
//  EditAddressProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

protocol EditAddressViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: EditAddressPresenterProtocol? { get set }
}

protocol EditAddressWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createEditAddressModule() -> UIViewController
}

protocol EditAddressPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: EditAddressViewProtocol? { get set }
    var interactor: EditAddressInteractorInputProtocol? { get set }
    var wireFrame: EditAddressWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol EditAddressInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol EditAddressInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: EditAddressInteractorOutputProtocol? { get set }
    var localDatamanager: EditAddressLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: EditAddressRemoteDataManagerInputProtocol? { get set }
}

protocol EditAddressDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol EditAddressRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: EditAddressRemoteDataManagerOutputProtocol? { get set }
}

protocol EditAddressRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol EditAddressLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
