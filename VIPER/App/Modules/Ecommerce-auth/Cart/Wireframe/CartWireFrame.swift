//
//  CartWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation
import UIKit

class CartWireFrame: CartWireFrameProtocol {

    class func createCartModule() -> UIViewController {
        let cartView = CartView()
        let viewController = cartView
        let presenter: CartPresenterProtocol & CartInteractorOutputProtocol = CartPresenter()
        let interactor: CartInteractorInputProtocol & CartRemoteDataManagerOutputProtocol = CartInteractor()
        let localDataManager: CartLocalDataManagerInputProtocol = CartLocalDataManager()
        let remoteDataManager: CartRemoteDataManagerInputProtocol = CartRemoteDataManager()
        let wireFrame: CartWireFrameProtocol = CartWireFrame()
        
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
    
    /*func navigateToModule(from view: CartViewProtocol?) {
        
        // Crear la vista de detalles del producto
        let productDetailVC = ProductDetailWireFrame.createProductDetailModule()
        
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
                navigationController.pushViewController(productDetailVC, animated: true)
            } else {
                // Si no está dentro de un UINavigationController, presentar el controlador de detalles del producto
                productDetailVC.modalPresentationStyle = .fullScreen
                viewController.present(productDetailVC, animated: true, completion: nil)
            }
        }
    }*/
}
