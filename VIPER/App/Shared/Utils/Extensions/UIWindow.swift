//
//  UIWindow.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 17/10/24.
//

import UIKit

extension UIWindow {
    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        let transition = animated ? UIView.AnimationOptions.transitionFlipFromRight : []
        
        // Configurar el nuevo rootViewController
        self.rootViewController = viewController
        self.makeKeyAndVisible()
        
        if animated {
            UIView.transition(with: self, duration: 0.3, options: transition, animations: nil, completion: nil)
        }
    }
}

