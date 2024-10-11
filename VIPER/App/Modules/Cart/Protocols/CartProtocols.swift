//
//  CartProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation
import UIKit

protocol CartViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CartPresenterProtocol? { get set }
}

protocol CartWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCartModule() -> UIViewController
}

protocol CartPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CartViewProtocol? { get set }
    var interactor: CartInteractorInputProtocol? { get set }
    var wireFrame: CartWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol CartInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol CartInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CartInteractorOutputProtocol? { get set }
    var localDatamanager: CartLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CartRemoteDataManagerInputProtocol? { get set }
}

protocol CartDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CartRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CartRemoteDataManagerOutputProtocol? { get set }
}

protocol CartRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CartLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
