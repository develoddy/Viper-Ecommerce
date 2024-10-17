//
//  WishlistWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation
import UIKit

class WishlistWireFrame: WishlistWireFrameProtocol {
   
    

    

    class func createWishlistModule() -> UIViewController {
        
        let wishlistView = WishlistView()
        let viewController = wishlistView
        let presenter: WishlistPresenterProtocol & WishlistInteractorOutputProtocol = WishlistPresenter()
        let interactor: WishlistInteractorInputProtocol & WishlistRemoteDataManagerOutputProtocol = WishlistInteractor()
        let localDataManager: WishlistLocalDataManagerInputProtocol = WishlistLocalDataManager()
        let remoteDataManager: WishlistRemoteDataManagerInputProtocol = WishlistRemoteDataManager()
        let wireFrame: WishlistWireFrameProtocol = WishlistWireFrame()
            
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
    
    func navigateToProductDetail(from view: WishlistViewProtocol?, with productId: Int, slug: String, discountId: Int?) {
        guard let discountId = discountId else { return }
        
        // Crear la vista de detalles del producto
        let productDetailVC = ProductDetailWireFrame.createProductDetailModule(productId: productId, slug: slug, discountId: discountId)
        
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
    }
    
    func navigateToLogin(from view: WishlistViewProtocol?) {
        
        let loginViewController = LoginWireFrame.createLoginModule {
            if let sourceView = view as? UIViewController {
                sourceView.dismiss(animated: true) { // Cierra el login
                    // Redirigir según el destino
                    let whislistViewController = WishlistWireFrame.createWishlistModule()
                    sourceView.present(whislistViewController, animated: true, completion: nil)
                }
            }
        }
        
        if let sourceView = view as? UIViewController {
            sourceView.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    /*func navigateToLogin(from view: WishlistViewProtocol?, for destination: String) {
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
    }*/
    
}
