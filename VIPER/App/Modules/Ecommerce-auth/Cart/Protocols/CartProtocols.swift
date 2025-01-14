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
    func updateUIList()
    func startActivity()
    func stopActivity()
    func updateFooter(with cart: CartsAPIResponse)
    func onError(_ error: Error)
}

protocol CartWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCartModule() -> UIViewController
    
    func navigateToLogin(from view: CartViewProtocol?) 
}

protocol CartPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CartViewProtocol? { get set }
    var interactor: CartInteractorInputProtocol? { get set }
    var wireFrame: CartWireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func numberOfItems() -> Int
    func getItem(at index: Int) -> CartAPIResponse?
    func didSelectProduct(at index: Int)
    func didTapLoginButton()
}

protocol CartInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrieveCarts(_ cartstResponse: CartsAPIResponse)
    func didFailToRetrieveCarts(with error: Error)
    func didFailToAuthenticateUser()
}

protocol CartInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CartInteractorOutputProtocol? { get set }
    var localDatamanager: CartLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CartRemoteDataManagerInputProtocol? { get set }
    
    func checkUserAuthentication()
    func fetchCarts(with userId: Int)
    
}

protocol CartDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CartRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CartRemoteDataManagerOutputProtocol? { get set }
    func fetchCarts(with userId: Int)
}

protocol CartRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onCartsRetrieved(with cartResponse: CartsAPIResponse)
    func onError(_ error: Error)
}

protocol CartLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
