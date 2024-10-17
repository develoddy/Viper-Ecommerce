//
//  LoginProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    func startActivity()
    func stopActivity()
    func showError(with error: String)
}

protocol LoginWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createLoginModule(completion: @escaping () -> Void) -> UIViewController
    func presentNewTabBarController()
    //func presentCartModule(from view: LoginViewProtocol?)
    func presentModule(for destination: String, from view: LoginViewProtocol?)
}

protocol LoginPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    var onLoginSuccess: (() -> Void)? { get set }
    func didAuthenticateUser()
    
    func viewDidLoad()
    func showTabBar(email: String, password: String)
    
}

protocol LoginInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(success: Bool)
}

protocol LoginInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
    
    func interactorGetData(email: String?, password: String?)
}

protocol LoginDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData(email: String?, password: String?)
}

protocol LoginRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(success: Bool)
}

protocol LoginLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
