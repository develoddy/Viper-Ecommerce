//
//  LoginRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation

class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    
    // MARK: - Closures
    // Through these closures, our view model will execute code while some events will occure
    // They will be set up by the view controller
    ///var reloadTableViewClosure      : (()->())?
    ///var showAlertClosure            : (()->())?
    ///var updateLoadingStatusClosure  : (()->())?
    
    // MARK: - Properties
        
    ///let apiService: APIServiceProtocol
    
    ///var success: Bool = false
    
    // A property containing the number ot items, it will be used by the view controller to render items on the screen using a
    ///var numberOfItems: Bool {
    ///    return success
    //}
    
    // The collection that will contain our fetched data
    ///var isLoading: Bool = false {
    ///    didSet {
    ///        self.updateLoadingStatusClosure?()
    ///    }
    ///}
    
    // MARK: Token
    // Initialize the Token App.
    ///private var token = Token()
    
    
    // MARK: - Constructor
    
    //init(apiService: APIServiceProtocol = APIService()) {
    //    self.apiService = apiService
    //}
    
    let apiService: APIServiceAuthProtocol
    
    init(apiService: APIServiceAuthProtocol = APIServiceAuth()) {
        self.apiService = apiService
    }
    
    func remoteGetData(email: String?, password: String?) {
        // self.isLoading = true
        apiService.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let loginResponse):
                print("Inicio de sesión exitoso: \(loginResponse)")
                self?.remoteRequestHandler?.remoteCallBackData(success: true) // Indicar éxito
            case .failure(let error):
                print("Error en inicio de sesión: \(error.localizedDescription)")
                self?.remoteRequestHandler?.remoteCallBackData(success: false) // Indicar fallo
            }
        }
        // self.isLoading = false
    }
    
    // LLAMAR AL SERVICIO Y OBTENER LOS DATOS
    //func remoteGetData(email: String?, password: String?) {
        //self.isLoading = true
        //apiService.login(email: email, password: password) { [weak self] success in
            // ENVIAR DE VUELTA LOS DATOS AL INTERACTOS
          //self?.remoteRequestHandler?.remoteCallBackData(success: success)
        //}
        //self.isLoading = false
    //}
}
