//
//  LoginPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 15/1/22.
//  
//

import Foundation


// MARK: PRESENTER
class LoginPresenter: LoginPresenterProtocol  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
    // Closure que se llama cuando el inicio de sesión es exitoso
    var onLoginSuccess: (() -> Void)?
    
    // Almacena la decisión de navegación (Cart o Wishlist)
    //var destinationModule: String?
    
    func viewDidLoad() {
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
    }
    
    // Método para manejar el resultado de la autenticación
    func didAuthenticateUser() {
        //print("LoginPResenet: didAuthenticateUser")
        onLoginSuccess?() // Llamar al callback
        //wireFrame?.presentCartModule(from: view)
        // Navegar a la vista correspondiente según la decisión de destino
        //if let destination = destinationModule {
            //print("LoginPResenet: \(destination)")
            //wireFrame?.presentModule(for: destination, from: view)
        //}
    }
    
    // VAMOS A LLAMAR AL WIREFRAME
    func showTabBar(email: String, password: String) {
        interactor?.interactorGetData(email: email, password: password)
        
        // LOAD ACTIVITY
        view?.startActivity()
    }
}



// MARK: PRESENTER OutputProtocol
extension LoginPresenter: LoginInteractorOutputProtocol {

    
    
    // RECIBE UN BOLEANO SI EL USUARIO FUE LOGUEADO CORRECTAMENTE O INCORRECTAMENTE
    // SI ES CORRECTO ENTONCES LLAMAMOS AL WIREFRAME PARA CAMBIO DE PANTALLA (TAB BAR CONTOLLER)
    // SI ES INCORRECTO ENTONCES "YA VEREMOS"...
    func interactorCallBackData(success: Bool) {
        ///print("LoginPresenter devuelta  Login Success !!! > \(success)")
        view?.stopActivity()
        //wireFrame?.presentNewTabBarController()
        
        if success {
            didAuthenticateUser() // Usuario autenticado correctamente
        } else {
            view?.showError(with: "Credenciales incorrectas.") // Mostrar error en caso de fallo
        }
    }
}
