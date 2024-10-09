//
//  FilterOptionsWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

class FilterOptionsWireFrame: FilterOptionsWireFrameProtocol {

    class func createFilterOptionsModule() -> UIViewController {
        
        let filterOptionsView = FilterOptionsView()
        let viewController = filterOptionsView
        let presenter: FilterOptionsPresenterProtocol & FilterOptionsInteractorOutputProtocol = FilterOptionsPresenter()
        let interactor: FilterOptionsInteractorInputProtocol & FilterOptionsRemoteDataManagerOutputProtocol = FilterOptionsInteractor()
        let localDataManager: FilterOptionsLocalDataManagerInputProtocol = FilterOptionsLocalDataManager()
        let remoteDataManager: FilterOptionsRemoteDataManagerInputProtocol = FilterOptionsRemoteDataManager()
        let wireFrame: FilterOptionsWireFrameProtocol = FilterOptionsWireFrame()
        
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
    
    /**func navigateToLoginView() {
        let loginViewController = LoginWireFrame.createLoginModule()
        
        // Obtén la escena activa
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }),
           let topController = window.rootViewController {
            
            // Si tienes un UINavigationController, navega usando él
            if let navigationController = topController as? UINavigationController {
                navigationController.pushViewController(loginViewController, animated: true)
            } else {
                // Si no es un UINavigationController, presenta el loginViewController de otra forma
                //loginViewController.modalPresentationStyle = .fullScreen
                topController.present(loginViewController, animated: true, completion: nil)
            }
        }
    }*/
    
}
