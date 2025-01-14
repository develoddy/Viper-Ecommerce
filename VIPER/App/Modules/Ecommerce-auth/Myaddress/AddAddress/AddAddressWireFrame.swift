//
//  AddAddressWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

class AddAddressWireFrame: AddAddressWireFrameProtocol {

    class func createAddAddressModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "AddAddressView")
        if let view = navController.children.first as? AddAddressView {
            let presenter: AddAddressPresenterProtocol & AddAddressInteractorOutputProtocol = AddAddressPresenter()
            let interactor: AddAddressInteractorInputProtocol & AddAddressRemoteDataManagerOutputProtocol = AddAddressInteractor()
            let localDataManager: AddAddressLocalDataManagerInputProtocol = AddAddressLocalDataManager()
            let remoteDataManager: AddAddressRemoteDataManagerInputProtocol = AddAddressRemoteDataManager()
            let wireFrame: AddAddressWireFrameProtocol = AddAddressWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "AddAddressView", bundle: Bundle.main)
    }
    
}
