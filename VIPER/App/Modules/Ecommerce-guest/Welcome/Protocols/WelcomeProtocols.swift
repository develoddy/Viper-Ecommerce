//
//  WelcomeProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//  
//

import Foundation
import UIKit

protocol WelcomeViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: WelcomePresenterProtocol? { get set }
}

protocol WelcomeWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createWelcomeModule() -> UIViewController
    func navigateToLoginView()
}

protocol WelcomePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: WelcomeViewProtocol? { get set }
    var interactor: WelcomeInteractorInputProtocol? { get set }
    var wireFrame: WelcomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func didTapContinue()
}

protocol WelcomeInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol WelcomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: WelcomeInteractorOutputProtocol? { get set }
    var localDatamanager: WelcomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: WelcomeRemoteDataManagerInputProtocol? { get set }
}

protocol WelcomeDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol WelcomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: WelcomeRemoteDataManagerOutputProtocol? { get set }
}

protocol WelcomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol WelcomeLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
