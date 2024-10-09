//
//  WelcomeWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//  
//

import Foundation
import UIKit

class WelcomeWireFrame: WelcomeWireFrameProtocol {
    
    class func createWelcomeModule() -> UIViewController {
        let welcomeView = WelcomeView()
        let viewController = welcomeView
        let presenter: WelcomePresenterProtocol & WelcomeInteractorOutputProtocol = WelcomePresenter()
        let interactor: WelcomeInteractorInputProtocol & WelcomeRemoteDataManagerOutputProtocol = WelcomeInteractor()
        let localDataManager: WelcomeLocalDataManagerInputProtocol = WelcomeLocalDataManager()
        let remoteDataManager: WelcomeRemoteDataManagerInputProtocol = WelcomeRemoteDataManager()
        let wireFrame: WelcomeWireFrameProtocol = WelcomeWireFrame()
        
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
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "WelcomeView", bundle: Bundle.main)
    }
    
    /*
     * Explicación de los Cambios:
     * Uso de connectedScenes: Ahora obtienes la escena activa usando UIApplication.shared.connectedScenes.
     * Esto es más seguro y compatible con múltiples escenas en iOS 13 y versiones posteriores.
     * isKeyWindow: Buscas la primera ventana que es la clave (isKeyWindow) para obtener el controlador raíz de esa ventana.
     * Navegación: Compruebas si el topController es un UINavigationController. Si lo es, usas pushViewController para navegar.
     * Si no, usas present para mostrar la vista de inicio de sesión de otra manera.
     */
    func navigateToLoginView() {
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
    }
}
