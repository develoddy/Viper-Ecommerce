//
//  ProfileBC.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//
// // Interfaz con WSApiRest para hacer login y guardar sesión.

import UIKit

// MARK: BCApiRest -> WSApiRest
class BCApiRest: NSObject {
    
    @discardableResult
    class func login(email: String?, password: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void) -> URLSessionDataTask? {
        
        // Validar parámetros
        guard let email = email, !email.isEmpty else {
            completion(.failure(BCApiError.emptyEmail))
            return nil
        }
        
        guard let password = password, !password.isEmpty else {
            completion(.failure(BCApiError.emptyPassword))
            return nil
        }
        
        // Llamar a WSApiRest para iniciar sesión
        return WSApiRest.login(email: email, password: password, completionCorrect: { (userResponse) in
            BCApiRest.saveSesion(deUsuario: userResponse)
            completion(.success(userResponse))
        }, completionIncorrect: { (errorMessage) in
            completion(.failure(BCApiError.unknown(errorMessage)))
        })
    }
    
    
    
    // Fetch List
    @discardableResult
    class func fetchList(timeNow: Int, token: String, completion: @escaping (Result<HomeListResponse, Error>) -> Void) -> URLSessionDataTask? {
        return WSApiRest.fetchList(timeNow: timeNow, token: token) { result in
            print("DEbbug: Soy BCApiRest: y me retorna: \(result)")
            completion(result)
        }
    }
    /*class func fetchList(timeNow: Int, completion: @escaping (Result<ListHomeResponse, Error>) -> Void) -> URLSessionDataTask? {
        // Llamar a WSApiRest para obtener la lista
        return WSApiRest.fetchList(timeNow: timeNow) { (result) in
            switch result {
            case .success(let listResponse):
                completion(.success(listResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }*/
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Start session
    /*@discardableResult
    class func logIn(email: String?, password: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void) -> URLSessionDataTask? {
        // Validar parámetros
        guard let email = email, !email.isEmpty else {
            completion(.failure(BCApiError.emptyEmail))
            return nil
        }
        guard let password = password, !password.isEmpty else {
            completion(.failure(BCApiError.emptyPassword))
            return nil
        }

        // Configurar la solicitud
        let url = URL(string: "https://api.lujandev.com/api/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Crear y comenzar la tarea de red
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(BCApiError.unknown(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(BCApiError.unknown("No data received")))
                return
            }
            
            do {
                // Decodificar la respuesta
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                // Guardar sesión
                saveSesion(deUsuario: loginResponse)
                completion(.success(loginResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Iniciar la tarea
        task.resume()
        return task*/
    
    
    
    
    // Login
    /*@discardableResult
    class func logIn(email: String?, password: String?, conCompletionCorrecto completioCorrecto: @escaping Closures.Login, conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        if email?.count == 0 {
            completionIncorrecto("You need enter your email")
            return nil
        }
        if password?.count == 0 {
            completionIncorrecto("You need enter your password")
            return nil
        }
            
        return WSApiRest.iniciarSesion( email:email, password: password, conCompletionCorrecto: { ( objUser ) in
            BCApiRest.saveSesion( deUsuario: objUser )
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto( mensajeError )
        })
    }*/
    
    //MARK: Close session
    /*@discardableResult class func logOut(_ token                                     : String?                          ,
                                         conCompletionCorrecto completioCorrecto     : @escaping Closures.LogOut        ,
                                         conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError  ) -> URLSessionDataTask? {
        return WSApiRest.sesionSignOut(token!, conCompletionCorrecto: { ( objUser ) in
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
    }*/
    
    
    //MARK: signIn
    /*@discardableResult class func signIn(_ objUser                                   : UserBE                          ,
                                         conCompletionCorrecto completioCorrecto     : @escaping Closures.Login        ,
                                         conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        if objUser.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        if objUser.username?.count == 0 {
            completionIncorrecto("You need enter your username")
            return nil
        }
        if objUser.email?.count == 0 {
            completionIncorrecto("You need enter your email")
            return nil
        }
        if objUser.password?.count == 0 {
            completionIncorrecto("You need enter your password")
            return nil
        }
            
        return WSApiRest.sesionSignIn( objUser, conCompletionCorrecto: { ( objUser ) in
            BCApiRest.guardarSesion( deUsuario: objUser )
            completioCorrecto( objUser )
        }, error: { ( mensajeError ) in
            completionIncorrecto( mensajeError )
        })
    }*/
    
    //MARK: Guardar session
    class func saveSesion(deUsuario objUsuario : LoginResponse) -> Void {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        do {
            print("Guardando sesión del usuario... \(objUsuario)")
            appDelegate.objUsuarioSesion = objUsuario
            let objUsuario = try JSONEncoder().encode( objUsuario ) ///encode data
            CDMKeyChain.guardarDataEnKeychain(
                try NSKeyedArchiver.archivedData(withRootObject: objUsuario, requiringSecureCoding: false),conCuenta: "CDMLogin", conServicio:"datosUsuario")
        } catch {
            print("Failed to save data... log: OSLog.default, type: .error")
        }
    }
    
    // MARK: USERPOST.
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el token
    /// Return object userpost o de lo contrario un mensaje de error.
    //@discardableResult class
    /*public func apiUserPostBC(_ token                                     : String?                         ,
                              conCompletionCorrecto completioCorrecto     : @escaping Closures.userPost     ,
                              conCompletionIncorrecto completionIncorrecto: @escaping Closures.MensajeError ) -> URLSessionDataTask? {
        
        let result = WSApiRest.startApiUserPost( token, conCompletionCorrecto: { ( data ) in
            completioCorrecto( data )
        }, error: { ( messageError ) in
            completionIncorrecto( messageError )
        })
        return result
    }*/
    
    //MARK: PROFILE.
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el objeto userSearch y el token
    /// Return object userpost o de lo contrario un mensaje de error.
    /*@discardableResult class func profile(_ email: String,
                                          _ token: String?,
                                          conCompletionCorrecto completioCorrecto: @escaping Closures.userPost,
                                          conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        if email.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        
        let resultSearch = WSApiRest.startProfile(email, token!, conCompletionCorrecto: { (objExplore) in
            completioCorrecto(objExplore)
        }, error: { (mensajeError) in
            completionIncorrecto(mensajeError)
        })
        
        return resultSearch
    }*/
    
    
    //MARK: LIKE.
    /// Vamos a llamar al backend para insertar o eliminar un like..
    /// Esta funcion recibe por parametros idpost, idUser
    /// Return messager.
    /*@discardableResult class func like(_ type_id: Int,
                                       _ ref_id: Int,
                                       _ users_id: Int,
                                       _ isLiked: Bool,
                                       _ token: String?,
                                       conCompletionCorrecto completioCorrecto: @escaping Closures.message,
                                       conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let resultSearch = WSApiRest.startLike(type_id,
                                               ref_id,
                                               users_id,
                                               isLiked,
                                               token!,
                                               conCompletionCorrecto: { ( objLike ) in
            completioCorrecto( objLike )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
        return resultSearch
    }*/
    
    //MARK: EXPLORE.
    /// Vamos a llamar al backend para traer los datos de la base de datos.
    /// Esta funcion recibe por parametros el objeto userSearch y el token
    /// Return object userpost o de lo contrario un mensaje de error.
    /*@discardableResult class func search(_ objSearch: UserSearchBE,
                                         _ token: String?,
                                         conCompletionCorrecto completioCorrecto: @escaping Closures.userPost,
                                         conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        if objSearch.name?.count == 0 {
            completionIncorrecto("You need enter your name")
            return nil
        }
        
        let resultSearch = WSApiRest.startSearch(objSearch, token!, conCompletionCorrecto: { ( objExplore ) in
            completioCorrecto(objExplore)
        }, error: { (mensajeError) in
            print("mensajeError")
            completionIncorrecto(mensajeError)
        })
        
        return resultSearch
    }*/
    
    
    //MARK: LIKED.
    /// Vamos a llamar al backend para insertar o eliminar un like..
    /// Esta funcion recibe por parametros idpost, idUser
    /// Return message.
    /*@discardableResult class func liked(_ ref_id: Int,
                                        _ users_id: Int,
                                        _ token: String?,
                                       conCompletionCorrecto completioCorrecto: @escaping Closures.message,
                                       conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let resultSearch = WSApiRest.startLiked(ref_id,
                                                users_id,
                                                token!,
                                                conCompletionCorrecto: { ( objLike ) in
            completioCorrecto( objLike )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
        return resultSearch
    }*/
    
    
    //MARK: CAPTION.
    /// Vamos a llamar al backend para actualizar el dato del caption del post.
    /// Esta funcion recibe por parametros: caption, idpost y token.
    /// Return message.
    /*@discardableResult class func postCaptionUpdate(_ caption: Caption,
                                                    _ idpost: Int,
                                                    _ token: String?,
                                                   conCompletionCorrecto completioCorrecto: @escaping Closures.message,
                                                   conCompletionIncorrecto completionIncorrecto : @escaping Closures.MensajeError) -> URLSessionDataTask? {
        let resultSearch = WSApiRest.startPostCaptionUpdate(caption,
                                                            idpost,
                                                            token!,
                                                            conCompletionCorrecto: { ( objCaption ) in
            completioCorrecto( objCaption )
        }, error: { ( mensajeError ) in
            completionIncorrecto(mensajeError)
        })
        return resultSearch
    }*/
}
