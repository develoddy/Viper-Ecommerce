//
//  Token.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//

import UIKit

class Token {
    static let shared = Token()
    
    public func getUserToken() -> LoginResponse? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil // O maneja el error de alguna manera
        }
        return appDelegate.objUsuarioSesion
    }
}


/*class Token {
    
    static let shared = Token()
    
    public func getUserToken() -> LoginResponse {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
}*/
