//
//  LoginWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
    

    //class func createLoginModule() -> UIViewController {
    class func createLoginModule(completion: @escaping () -> Void) -> UIViewController {
        let loginView = LoginView()
        let viewController = loginView
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        // Configurar el callback en el presenter
        presenter.onLoginSuccess = completion
        
        return viewController
    }
    
    // MARK: - SE ENCARGA DE NAVERGAR AL TAB BAR CONTROLLER.
    func presentNewTabBarController() {
        let submodules = (
            home: HomeWireFrame.createHomeModule(),
            search: UIViewController(),
            profile: ProfileWireFrame.createProfileModule(),
            wishlist: WishlistWireFrame.createWishlistModule(),
            cart: CartWireFrame.createCartModule()
        )
        
        let tabBarController = TabBarModuleBuilder.build(usingSubmodules: submodules)
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let obj = appDelegate.objUsuarioSesion
        let token = obj?.token
        
        if token != nil {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
        } else {
            //print("LoginWireFrame -  No hay token")
        }
    }
    
    func presentModule(for destination: String, from view: LoginViewProtocol?) {
        
        print("LoginWireFrame: destination: \(destination)")
        
        guard let sourceView = view as? UIViewController else { return }

        switch destination {
        case "Cart":
            let cartViewController = CartWireFrame.createCartModule() // Asegúrate de tener este método
            sourceView.present(cartViewController, animated: true, completion: nil)
        case "Wishlist":
            let wishlistViewController = WishlistWireFrame.createWishlistModule() // Asegúrate de tener este método
            sourceView.present(wishlistViewController, animated: true, completion: nil)
        default:
            break
        }
    }
}
