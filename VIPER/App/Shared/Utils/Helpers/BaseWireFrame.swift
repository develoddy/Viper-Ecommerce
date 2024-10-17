//
//  BaseWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/10/24.
//

import UIKit

class BaseWireFrame {
    
    /* 
     * Crear una Clase Base o una Extensión
     * Puedes crear una clase base o una extensión que contenga las funciones de navegación comunes que
     * puedan ser utilizadas por diferentes módulos. Esto te permitirá evitar duplicación y mantener la
     * lógica centralizada.
     */
    
    func changeRootViewController(to viewController: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.changeRootViewController(viewController)
            }
        }
    }
    
    func presentLogin(from view: UIViewController, completion: @escaping () -> Void) {
        let loginViewController = LoginWireFrame.createLoginModule(completion: completion)
        loginViewController.modalPresentationStyle = .fullScreen
        view.present(loginViewController, animated: true, completion: nil)
    }
}

