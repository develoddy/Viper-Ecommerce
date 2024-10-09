//
//  WebTranslator.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//
// // Traduce la respuesta del servicio web en modelos usados por la app.

import UIKit

class WSTranslator: NSObject {
   
    
    class func translateResponseTokenBE(_ data: Data, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        do {
            // Decodificar el JSON usando el modelo UserFrontedResponse.
            let userFrontedResponse = try JSONDecoder().decode(UserFrontedResponse.self, from: data)
            
            // Llamar al completion con éxito pasando el LoginResponse.
            completion(.success(userFrontedResponse.userFronted))
        } catch let error {
            print("Error decoding response: \(error.localizedDescription)")
            // Llamar al completion con fallo.
            completion(.failure(error))
        }
    }
    
    
    // Nuevo método para traducir la respuesta de la lista de inicio
    class func translateResponseListHome(_ data: Data, completion: @escaping (Result<HomeListResponse, Error>) -> Void) {
        do {
            // Decodificar el JSON usando el modelo HomeListResponse.
            let homeListResponse = try JSONDecoder().decode(HomeListResponse.self, from: data)
            
            // Llamar al completion con éxito pasando el HomeListResponse.
            completion(.success(homeListResponse))
        } catch let error {
            print("Error decoding home list response: \(error.localizedDescription)")
            // Llamar al completion con fallo.
            completion(.failure(error))
        }
    }
    
    
    
    
    
    
    
    
    //MARK: LOGOUT TRANSLATOR RESPONSE.
    ///Return Object mensaje logout.
    /*class func translateResponseLogOutBE(_ objDic: NSDictionary) -> ResponseLogOutBE {
        let objLogOutBE = ResponseLogOutBE()
        objLogOutBE.message = objDic["message"] as? String
        return objLogOutBE
    }*/
}

