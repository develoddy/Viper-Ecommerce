//
//  SceneDelegate.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    // MARK: VALIDAMOS SI EL USUARIO TIENE EL TOKEN O SI NO ESTÁ LOGUEADO
    // SI TIENE EL TOKEN ENTONCES MOSTRAMOS EL TABBARCONTROLLER
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        // Asegúrate de que la escena sea del tipo UIWindowScene
        guard let windowScene = scene as? UIWindowScene else { return }
        
        // Obtén la instancia de AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let obj = appDelegate.objUsuarioSesion
        let token = obj?.token

        // Validaciones
        let window = UIWindow(windowScene: windowScene)
        
        if token != nil {
            // Si no hay token, muestra el flujo de inicio de sesión
            let loginViewController = LoginWireFrame.createLoginModule() // Crear el módulo de inicio de sesión
            window.rootViewController = loginViewController
        } else {
            // Si hay token, muestra el TabBarController
            let submodules = (
                home: HomeWireFrame.createHomeModule(),
                search: UIViewController(),
                profile: ProfileWireFrame.createProfileModule(),
                wishlist: WishlistWireFrame.createWishlistModule(),
                cart: CartWireFrame.createCartModule()
            )
            let tabBarController = TabBarModuleBuilder.build(usingSubmodules: submodules)
            window.rootViewController = tabBarController
        }
        
        self.window = window
        window.makeKeyAndVisible()
        
        
        
    
        // Asegúrate de que la escena sea del tipo UIWindowScene
        /**guard let windowScene = (scene as? UIWindowScene) else { return }
        let appDelegate = AppDelegate()
        let obj = appDelegate.objUsuarioSesion
        let token = obj?.token

        //MARK: VALIDATIONS
        if token == nil {
            let submodules = (
                home: HomeWireFrame.createHomeModule(),
                search: UIViewController(),
                profile: ProfileWireFrame.createProfileModule(),
                wishlist: WishlistWireFrame.createWishlistModule(),
                cart: CartWireFrame.createCartModule()
            )

            let window                  = UIWindow(windowScene: windowScene)
            let tabBarController        = TabBarModuleBuilder.build(usingSubmodules: submodules)
            window.rootViewController   =  tabBarController
            self.window                 = window
            window.makeKeyAndVisible()
        } else {
            /**let window = UIWindow(windowScene: windowScene)
            let viewController = HomeWireFrame.createHomeModule() //LoginWireFrame.createLoginModule()
            viewController.modalPresentationStyle = .fullScreen
            window.rootViewController = viewController
            self.window = window
            window.makeKeyAndVisible()*/
        }*/
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    //MARK: ROOT VIEWCONTROLLER
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc
        vc.modalPresentationStyle = .fullScreen
        //UIView.transition(with: window, duration: 0.8, options: .transitionCurlUp, animations: nil)
    }
}

