//
//  WebModel.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 6/4/21.
//
// // Encargado de gestionar las llamadas a web services (login).


import UIKit

// MARK: WSApiRest -> WSender
class WSApiRest: NSObject {
    
    static let CDMWebModelURLBase : NSString = Constants.ApiRoutes.api as NSString
    
    // URL
    /*static let _URL_userpost    = "api/auth/home/userpost"
    static let _URL_profile     = "api/auth/home/profile"
    static let _URL_explore     = "api/auth/home/explore"
    static let _URL_logout      = "api/auth/logout"*/
    
    // Login cliente
    static let _URL_login = "/api/users/login"
    static let _URL_home_list = "/api/home/list"
    /*static let _URL_signup      = "api/auth/signup"
    static let _URL_like        = "api/auth/likes/insert"
    static let _URL_liked       = "api/auth/likes/liked"
    static let _URL_caption     = "api/auth/post/updateCaption"*/

    // Iniciar Session
    @discardableResult
    
    class func login(email: String?, password: String?, completionCorrect: @escaping Closures.Login, completionIncorrect: @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        // Validar email y contraseña
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {
            completionIncorrect("Email or password is missing")
            return nil
        }

        // Crear el diccionario con los parámetros
        let dic: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        return WSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: _URL_login as NSString, conParametros: dic) { (objectResponse) in
            
            guard let _ = objectResponse.dataResponse else {
                print("Debbug WSApiRest: Error Respuesta del servidor no válida o formato de datos inesperado")
                completionIncorrect("Invalid server response")
                return
            }
            
            // Aquí deberías extraer la Data de la respuesta
            guard let data = objectResponse.dataResponse else {
                print("Debbug WSApiRest: No se pudo obtener datos de la respuesta")
                completionIncorrect("No data found")
                return
            }
            
            // Llamar a translateResponseTokenBE con el Data
            WSTranslator.translateResponseTokenBE(data) { result in
                switch result {
                case .success(let loginResponse):
                    print("Debbug WSApiRest : Inicio de sesión Exitoso en APIService: \(loginResponse)")
                    completionCorrect(loginResponse)
                case .failure(let error):
                    print("Debbug WSApiRest : Inicio de sesión Incorrecto en APIService: \(error.localizedDescription)")
                    completionIncorrect(error.localizedDescription)
                }
            }
        }
    }
    
    // Fetch List
    @discardableResult
    class func fetchList(timeNow: Int, token: String, completion: @escaping (Result<HomeListResponse, Error>) -> Void) -> URLSessionDataTask? {
        
        
        print("DEbbug: Soy WSApiRest: y me llega token: \(token)")
        print("DEbbug: Soy WSApiRest: y me llega timeNow: \(timeNow)")
        
        ///let url = URL(string: "https://tuapi.com/list?TIME_NOW=\(timeNow)")! // Asegúrate de usar la URL correcta
        
        // Crear el diccionario con los parámetros
        let parameters: [String: Any] = ["timeNow": timeNow]

        // Llamar a WSender para hacer la solicitud GET
        return WSender.doGETTokenToURL(conURL: self.CDMWebModelURLBase,
                                       conPath: _URL_home_list as NSString, //"/api/list",  // Cambia esto a la ruta correcta de tu API
                                       conParametros: parameters,
                                       conToken: token) { response in
            // Manejo de la respuesta
            guard let dataResponse = response.dataResponse else {
                print("Error: respuesta del servidor no válida o formato de datos inesperado")
                completion(.failure(BCApiError.unknown("Invalid server response")))
                return
            }
            
            // Llamar a translateResponseListHome con el Data
            // WSTranslator.translateResponseListHome(dataResponse) { result in
            WSTranslator.translateResponseListHome(dataResponse) { result in
                switch result {
                case .success(let listResponse):
                    print("Fetch list exitoso: \(listResponse)")
                    completion(.success(listResponse))
                case .failure(let error):
                    print("Error al obtener la lista: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: Session Sign out
    ///Llamaremos al backend.
    ///Recibe por parametros el tokekn de la App.
    /*@discardableResult
    class func sesionSignOut(_ token                                 : String                         ,
                             conCompletionCorrecto completionCorrecto: @escaping Closures.LogOut      ,
                             error procesoIncorrecto                 : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [Any]? = nil
        return WSender.doPOSTTokenToURL(conURL: self.CDMWebModelURLBase, conPath: _URL_logout as NSString, conParametros: dic,  conToken: token) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    let objUsuario = WSTranslator.translateResponseLogOutBE(diccionarioRespuesta!)
                    completionCorrecto(objUsuario)
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }*/

    
    
    /*@discardableResult
    class func iniciarSesion(email: String?, password: String?, conCompletionCorrecto completionCorrecto: @escaping Closures.Login, error procesoIncorrecto: @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        //guard let email = email, let password = password else { return  nil }
        
        guard let email = email, let password = password else {
            procesoIncorrecto("Email or password is missing")
            return nil
        }
        
        //let dic : [String : Any] = ["email": email, "password": password, "typedevice": 1, "tokendevice" : "Se debe enviar el token push del dispositivo"]
        let dic : [String : Any] = ["email": email, "password": password]
        return WSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: _URL_login as NSString, conParametros: dic) { (objRespuesta) in
            guard let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary else {
                procesoIncorrecto("Invalid server response")
                print("Error: Invalid server response or unexpected data format")
                return
            }
            
            print("Response received: \(diccionarioRespuesta)")
            
            // Revisar si existe un campo de error en la respuesta
            if let arrayRespuesta = diccionarioRespuesta["error"] as? String {
                let mensajeError = WSApiRest.getErrorMessage(paraData: diccionarioRespuesta)
                print("Error found in response: \(mensajeError)")
                
                if arrayRespuesta == Constants.Error.unauthorized {
                    let mensajeErrorFinal = diccionarioRespuesta.count == 0 ? Constants.LogInError.logInInvalidte : mensajeError
                    print("Error: Unauthorized - \(mensajeErrorFinal)")
                    procesoIncorrecto(mensajeErrorFinal)
                } else {
                    print("Error: \(arrayRespuesta)")
                    procesoIncorrecto("Unknown error: \(arrayRespuesta)")
                }
            } else {
                // Si no hay error, proceder con el manejo de éxito
                print("No error found in response, proceeding with success handling.")
                WSTranslator.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                    switch result {
                    case .success(let userPost):
                        print("Success: User post fetched successfully.")
                        completionCorrecto(userPost)
                    case .failure(let error):
                        print("Error during translation: \(error.localizedDescription)")
                        procesoIncorrecto(error.localizedDescription)
                    }
                }
            }
            
        }
    }*/
    
    //MARK: Session Sign in
    ///Llamaremos al backend.
    ///Recibe por parametros el tokekn de la App.
    /*@discardableResult
    class func sesionSignIn(_ objUser                                : UserBE                         ,
                            conCompletionCorrecto completionCorrecto : @escaping Closures.Login       ,
                            error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["name"          : objUser.name!                                 ,
                                    "username"      : objUser.username!                             ,
                                    "email"         : objUser.email!                                ,
                                    "password"      : objUser.password!                             ,
                                    "typedevice"    : 1                                             ,
                                    "tokendevice"   : "Se debe enviar el token push del dispositivo"]
        
        return WSender.doPOSTToURL(conURL: self.CDMWebModelURLBase, conPath: _URL_signup as NSString, conParametros: dic) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta = diccionarioRespuesta!["error"]
            let mensajeError = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseTokenBE(diccionarioRespuesta) { (result) in
                        switch result {
                            case .success(let userPost): completionCorrecto(userPost)
                            case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if arrayRespuesta as! String == Constants.Error.unauthorized {
                    let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte : mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
    }*/

    //MARK: USERPOST A CALL IS MDADE TO THE BACKEND.
    ///Parametros Token & UserPost
    /*@discardableResult class
    func startApiUserPost(_ token                                 : String?                        ,
                          conCompletionCorrecto completionCorrecto: @escaping Closures.userPost    ,
                          error procesoIncorrecto                 : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [Any]? = nil ///let dic : [String : Any] = [ "tabs": tabs as Any ]
        let result = WSender.doGETTokenToURL(conURL       : WSApiRest.CDMWebModelURLBase ,
                                             conPath      : _URL_userpost as NSString    ,
                                             conParametros: dic                          ,
                                             conToken     : token ?? ""                  ) { (objRespuesta) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseUserPostBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return result
    }*/
    
    //MARK: PROFILE A CALL IS MDADE TO THE BACKEND.
    ///Explore
    ///Parametros Token y Object UserSearchBE
    /*@discardableResult class func startProfile(_ email                                  : String                         ,
                                              _ token                                  : String?                        ,
                                              conCompletionCorrecto completionCorrecto : @escaping Closures.userPost    ,
                                              error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        
        let dic : [String : Any] = ["email"       : email                                        ,
                                    "typedevice" : 1                                             ,
                                    "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSender.doPOSTTokenToURL(conURL       : self.CDMWebModelURLBase  ,
                                                    conPath      : _URL_profile as NSString ,
                                                    conParametros: dic                      ,
                                                    conToken     : token ?? ""              ) { ( objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseProfileBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }*/
    
    
    //MARK: LIKES A CALL IS MDADE TO THE BACKEND.
    ///Like
    ///Parametros Token y Object UserSearchBE
    /*@discardableResult class func startLike(_ type_id                                : Int                            ,
                                            _ ref_id                                 : Int                            ,
                                            _ users_id                               : Int                            ,
                                            _ isLiked                                : Bool                           ,
                                            _ token                                  : String?                        ,
                                            conCompletionCorrecto completionCorrecto : @escaping Closures.message     ,
                                            error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["type_id"    : type_id                                       ,
                                    "ref_id"     : ref_id                                        ,
                                    "users_id"   : users_id                                      ,
                                    "isLiked"    : isLiked                                       ,
                                    "typedevice" : 1                                             ,
                                    "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSender.doPOSTTokenToURL(conURL       : self.CDMWebModelURLBase  ,
                                                    conPath      : _URL_like as NSString    ,
                                                    conParametros: dic                      ,
                                                    conToken     : token ?? ""              ) { ( objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseLikeBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let message): completionCorrecto(message)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }*/
    
    
    //MARK: EXPLORE A CALL IS MDADE TO THE BACKEND.
    ///Explore
    ///Parametros Token y Object UserSearchBE
    /*@discardableResult class func startSearch(_ objSearch                              : UserSearchBE                   ,
                                              _ token                                  : String?                        ,
                                              conCompletionCorrecto completionCorrecto : @escaping Closures.userPost  ,
                                              error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["name"       : objSearch.name ?? ""                          ,
                                    "typedevice" : 1                                             ,
                                    "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSender.doPOSTTokenToURL(conURL       : self.CDMWebModelURLBase  ,
                                                    conPath      : _URL_explore as NSString ,
                                                    conParametros: dic                      ,
                                                    conToken     : token ?? ""              ) { ( objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseExploreBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let userPost): completionCorrecto(userPost)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }*/
    
    //MARK: LIKED A CALL IS MDADE TO THE BACKEND.
    ///Liked
    ///Parametros ref_id, users_id, token.
    /*@discardableResult class func startLiked(_ ref_id                                 : Int                            ,
                                            _ users_id                               : Int                            ,
                                            _ token                                  : String?                        ,
                                            conCompletionCorrecto completionCorrecto : @escaping Closures.message     ,
                                            error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["ref_id"     : ref_id                                        ,
                                    "users_id"   : users_id                                      ,
                                    "typedevice" : 1                                             ,
                                    "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSender.doPOSTTokenToURL(conURL       : self.CDMWebModelURLBase  ,
                                                    conPath      : _URL_liked as NSString    ,
                                                    conParametros: dic                      ,
                                                    conToken     : token ?? ""              ) { ( objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseLikedBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let message): completionCorrecto(message)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }*/
    
    
    
    
    
    
    //MARK: POST CAPTION UPDATE MDADE TO THE BACKEND.
    ///Caption update
    ///Parametros Caption, idpost , token.
    /*@discardableResult class func startPostCaptionUpdate(_ caption                                : Caption                        ,
                                                         _ idpost                                 : Int                            ,
                                                         _ token                                  : String?                        ,
                                                         conCompletionCorrecto completionCorrecto : @escaping Closures.message     ,
                                                         error procesoIncorrecto                  : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let dic : [String : Any] = ["content"    : caption.content ?? ""                         ,
                                    "typedevice" : 1                                             ,
                                    "tokendevice": "Se debe enviar el token push del dispositivo"]
        let resultSearch = WSender.doPUTTokenToURL(conURL        : self.CDMWebModelURLBase  ,
                                                   conPath      : _URL_caption+"/"+"\(idpost)" as NSString    ,
                                                    conParametros: dic                      ,
                                                    conToken     : token ?? ""              ) { ( objRespuesta ) in
            let diccionarioRespuesta = objRespuesta.respuestaJSON as? NSDictionary
            let arrayRespuesta       = diccionarioRespuesta?["error"]
            let mensajeError         = WSApiRest.obtenerMensajeDeError(paraData: diccionarioRespuesta)
            if arrayRespuesta == nil {
                if diccionarioRespuesta != nil && diccionarioRespuesta!.count != 0 {
                    guard let diccionarioRespuesta = diccionarioRespuesta else { return }
                    WSTranslator.translateResponseCaptionBE(diccionarioRespuesta) { ( result ) in
                        switch result {
                        case .success(let message): completionCorrecto(message)
                        case .failure(let error): print(error.localizedDescription)
                        }
                    }
                }
            } else if  arrayRespuesta as! String == Constants.Error.unauthorized {
                let mensajeErrorFinal = (diccionarioRespuesta != nil && diccionarioRespuesta?.count == 0) ? Constants.LogInError.logInInvalidte: mensajeError
                   procesoIncorrecto(mensajeErrorFinal)
            }
        }
        return resultSearch
    }*/
    
    
    
    
    //MARK: Manejo de mensajes de error y status.
    ///Return object mensaje error.
    class func getErrorMessage(paraData data : NSDictionary?) -> String {
        var mensajeError = Constants.LogInError.mensajeError
        if data != nil && data?["data_error"] != nil  {
            let dataError = data?["data_error"] as? NSDictionary
            if dataError != nil && dataError?["msg"] != nil {
                mensajeError = dataError?["msg"] as! String
            }
        }
        return mensajeError
    }
}

