//
//  AppDelegate.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    // Variable para almacenar el objeto de sesión del usuario
   
    var objUsuarioSesion: LoginResponse?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Inicializa objUsuarioSesion aquí
        // Asegúrate de crear un objeto LoginResponse válido
        objUsuarioSesion = LoginResponse(token: nil, user: nil) // Asegúrate de que LoginResponse tenga un inicializador adecuado
        
        // Si LoginResponse requiere parámetros, inicialízalo de acuerdo a tus necesidades.
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

