//
//  ProfileWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation
import UIKit

class ProfileWireFrame: ProfileWireFrameProtocol {

    class func createProfileModule() -> UIViewController {
        
        let profileView = ProfileView()
        let viewController = profileView
        
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter()
        let interactor: ProfileInteractorInputProtocol & ProfileRemoteDataManagerOutputProtocol = ProfileInteractor()
        let localDataManager: ProfileLocalDataManagerInputProtocol = ProfileLocalDataManager()
        let remoteDataManager: ProfileRemoteDataManagerInputProtocol = ProfileRemoteDataManager()
        let wireFrame: ProfileWireFrameProtocol = ProfileWireFrame()
        
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
