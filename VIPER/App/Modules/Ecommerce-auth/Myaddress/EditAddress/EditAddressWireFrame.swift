//
//  EditAddressWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

class EditAddressWireFrame: EditAddressWireFrameProtocol {

    class func createEditAddressModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "EditAddressView")
        if let view = navController.children.first as? EditAddressView {
            let presenter: EditAddressPresenterProtocol & EditAddressInteractorOutputProtocol = EditAddressPresenter()
            let interactor: EditAddressInteractorInputProtocol & EditAddressRemoteDataManagerOutputProtocol = EditAddressInteractor()
            let localDataManager: EditAddressLocalDataManagerInputProtocol = EditAddressLocalDataManager()
            let remoteDataManager: EditAddressRemoteDataManagerInputProtocol = EditAddressRemoteDataManager()
            let wireFrame: EditAddressWireFrameProtocol = EditAddressWireFrame()
            
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
        return UIStoryboard(name: "EditAddressView", bundle: Bundle.main)
    }
    
}
