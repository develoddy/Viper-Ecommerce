//
//  WelcomePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//  
//

import Foundation

class WelcomePresenter  {
    
    // MARK: Properties
    weak var view: WelcomeViewProtocol?
    var interactor: WelcomeInteractorInputProtocol?
    var wireFrame: WelcomeWireFrameProtocol?
    
}

extension WelcomePresenter: WelcomePresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    // Método para manejar la acción del botón Continuar
    func didTapContinue() {
        wireFrame?.navigateToLoginView() // Llama al método en el wireframe
    }
}

extension WelcomePresenter: WelcomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
