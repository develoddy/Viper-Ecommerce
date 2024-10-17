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
    
    
    func navigateToLogin(from view: CartViewProtocol?) {
        // Crear la vista de inicio de sesión
        let loginViewController = LoginWireFrame.createLoginModule {
            // Regresar al módulo del carrito después de iniciar sesión
            if let sourceView = view as? UIViewController {
                sourceView.dismiss(animated: true) { // Cierra el login
                    let cartViewController = CartWireFrame.createCartModule()
                    sourceView.present(cartViewController, animated: true, completion: nil) // Presenta el carrito
                }
            }
        }
        
        if let sourceView = view as? UIViewController {
            sourceView.present(loginViewController, animated: true, completion: nil)
        }
    }
    
   
    //func navigateToLogin(from view: CartViewProtocol?) {
        
        // Crear la vista de detalles del producto
    //    let loginViewController = LoginWireFrame.createLoginModule()
    //    if let sourceView = view as? UIViewController {
    //        sourceView.present(loginViewController, animated: true, completion: nil)
    //    }
        
        // Verificar que la vista (view) sea un controlador de vista válido
        /*
         let productDetailVC = LoginWireFrame.createLoginModule()
         if let viewController = view as? UIViewController {
            
            // Si está dentro de un UINavigationController, usar el push para navegar
            if let navigationController = viewController.navigationController {
                print("Debbug: CartWireframe entra por: un UINavigationController, usar el PUSH para navegar")
                navigationController.pushViewController(productDetailVC, animated: true)
            } else {
                print("Debbug: CartWireframe entra por: PRESENTER el controlador de detalles del producto")
                // Si no está dentro de un UINavigationController, presentar el controlador de detalles del producto
                productDetailVC.modalPresentationStyle = .fullScreen
                viewController.present(productDetailVC, animated: true, completion: nil)
            }
        }*/
    //}
}
