//
//  ListAddressWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

class ListAddressWireFrame: ListAddressWireFrameProtocol {

    class func createListAddressModule() -> UIViewController {
        
        let listAddressView = ListAddressView()
        let viewController = listAddressView
        
        let presenter: ListAddressPresenterProtocol & ListAddressInteractorOutputProtocol = ListAddressPresenter()
        let interactor: ListAddressInteractorInputProtocol & ListAddressRemoteDataManagerOutputProtocol = ListAddressInteractor()
        let localDataManager: ListAddressLocalDataManagerInputProtocol = ListAddressLocalDataManager()
        let remoteDataManager: ListAddressRemoteDataManagerInputProtocol = ListAddressRemoteDataManager()
        let wireFrame: ListAddressWireFrameProtocol = ListAddressWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
}
