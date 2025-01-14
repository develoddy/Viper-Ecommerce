//
//  CartWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation
import UIKit

class CartWireFrame: BaseWireFrame, CartWireFrameProtocol {

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
    
    /*
     * Heredar de la Clase Base en WishlistWireFrame
     * Luego puedes hacer que WishlistWireFrame herede de BaseWireFrame y usar las
     * funciones compartidas.
     */
    func navigateToLogin(from view: CartViewProtocol?) {
        guard let sourceView = view as? UIViewController else { return }
        
        presentLogin(from: sourceView) { [weak sourceView] in
            sourceView?.dismiss(animated: true) {
                let tabBarController = self.createTabBarController()
                tabBarController.selectedIndex = 4 // Index de Wishlist
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
