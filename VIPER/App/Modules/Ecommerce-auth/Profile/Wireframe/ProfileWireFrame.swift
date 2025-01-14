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
    
    //func navigateToProductDetail(from view: HomeViewProtocol?, with productId: Int, slug: String, discountId: Int?) {
    func navigateToListAddressView(from view: ProfileViewProtocol?) {
        
        // Crear la vista de detalles del producto
        let listAddressVC = ListAddressWireFrame.createListAddressModule()
        
        // Verificar que la vista (view) sea un controlador de vista válido
        if let viewController = view as? UIViewController {
            
            // Personalizar el botón "Back" para el controlador anterior
            let backItem = UIBarButtonItem()
            backItem.title = ""  // Quitar el texto
            viewController.navigationItem.backBarButtonItem = backItem
            
            // Cambiar el color de la flecha de "Back" a negro
            viewController.navigationController?.navigationBar.tintColor = .black
            
            // Si está dentro de un UINavigationController, usar el push para navegar
            if let navigationController = viewController.navigationController {
                navigationController.pushViewController(listAddressVC, animated: true)
            } else {
                // Si no está dentro de un UINavigationController, presentar el controlador de detalles del producto
                listAddressVC.modalPresentationStyle = .fullScreen
                viewController.present(listAddressVC, animated: true, completion: nil)
            }
        }
    }
    
    /**func navigateToListAddressView() {
        let listAddressViewController = ListAddressWireFrame.createListAddressModule()
        
        // Obtén la escena activa
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }),
           let topController = window.rootViewController {
            
            // Si tienes un UINavigationController, navega usando él
            if let navigationController = topController as? UINavigationController {
                navigationController.pushViewController(listAddressViewController, animated: true)
            } else {
                // Si no es un UINavigationController, presenta el FilterOptionsViewController de otra forma
                topController.present(listAddressViewController, animated: true, completion: nil)
            }
        }
    }*/
}
