//
//  WishlistWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation
import UIKit

class WishlistWireFrame: BaseWireFrame, WishlistWireFrameProtocol {
   
    

    

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
    
    
    /*
     * Heredar de la Clase Base en WishlistWireFrame
     * Luego puedes hacer que WishlistWireFrame herede de BaseWireFrame y usar las funciones compartidas.
     */
    func navigateToLogin(from view: WishlistViewProtocol?) {
        guard let sourceView = view as? UIViewController else { return }
        
        presentLogin(from: sourceView) { [weak sourceView] in
            sourceView?.dismiss(animated: true) {
                let tabBarController = self.createTabBarController()
                tabBarController.selectedIndex = 3 // Index de Wishlist
                self.changeRootViewController(to: tabBarController)
            }
        }
    }

    
    private func createTabBarController() -> UITabBarController {
        let submodules = (
            home: HomeWireFrame.createHomeModule(),
            search: UIViewController(),
            profile: ProfileWireFrame.createProfileModule(),
            wishlist: WishlistWireFrame.createWishlistModule(),
            cart: CartWireFrame.createCartModule()
        )
        return TabBarModuleBuilder.build(usingSubmodules: submodules)
    }

}
