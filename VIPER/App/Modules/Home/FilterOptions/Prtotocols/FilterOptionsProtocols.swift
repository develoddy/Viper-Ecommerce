//
//  FilterOptionsProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

protocol FilterOptionsViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: FilterOptionsPresenterProtocol? { get set }
}

protocol FilterOptionsWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createFilterOptionsModule() -> UIViewController
}

protocol FilterOptionsPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: FilterOptionsViewProtocol? { get set }
    var interactor: FilterOptionsInteractorInputProtocol? { get set }
    var wireFrame: FilterOptionsWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol FilterOptionsInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol FilterOptionsInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: FilterOptionsInteractorOutputProtocol? { get set }
    var localDatamanager: FilterOptionsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FilterOptionsRemoteDataManagerInputProtocol? { get set }
}

protocol FilterOptionsDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol FilterOptionsRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: FilterOptionsRemoteDataManagerOutputProtocol? { get set }
}

protocol FilterOptionsRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol FilterOptionsLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
