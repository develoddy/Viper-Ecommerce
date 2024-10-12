//
//  WishlistProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation
import UIKit

protocol WishlistViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: WishlistPresenterProtocol? { get set }
}

protocol WishlistWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createWishlistModule() -> UIViewController
}

protocol WishlistPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: WishlistViewProtocol? { get set }
    var interactor: WishlistInteractorInputProtocol? { get set }
    var wireFrame: WishlistWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol WishlistInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol WishlistInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: WishlistInteractorOutputProtocol? { get set }
    var localDatamanager: WishlistLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: WishlistRemoteDataManagerInputProtocol? { get set }
}

protocol WishlistDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol WishlistRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: WishlistRemoteDataManagerOutputProtocol? { get set }
}

protocol WishlistRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol WishlistLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
