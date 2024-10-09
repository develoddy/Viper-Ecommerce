//
//  ProductDetailProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ProductDetailPresenterProtocol? { get set }
}

protocol ProductDetailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createProductDetailModule(product: ProductModel?) -> UIViewController
}

protocol ProductDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProductDetailViewProtocol? { get set }
    var interactor: ProductDetailInteractorInputProtocol? { get set }
    var wireFrame: ProductDetailWireFrameProtocol? { get set }
    var product: ProductModel? { get set }
    
    func viewDidLoad()
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol ProductDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProductDetailInteractorOutputProtocol? { get set }
    var localDatamanager: ProductDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProductDetailRemoteDataManagerInputProtocol? { get set }
}

protocol ProductDetailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProductDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProductDetailRemoteDataManagerOutputProtocol? { get set }
}

protocol ProductDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ProductDetailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
