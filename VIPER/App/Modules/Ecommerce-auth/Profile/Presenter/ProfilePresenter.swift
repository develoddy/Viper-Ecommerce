//
//  ProfilePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol  {
    
    // MARK: Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func logoutButtonTapped() {
        // El interactor maneja la lógica de cierre de sesión
        interactor?.logout()
    }
    
    func didTapNavigationToListAddress(at index: Int) {
        // EL wireframe maneja la lógica de navegar a la vista de listar las direcciones postales
        switch index {
            case 0:
                print("Navegar a la vista de compras")
                ///router?.navigateToPurchases()
            case 1:
                print("Navegar a la vista de devoluciones")
                ///router?.navigateToReturns()
            case 2:
                print("Navegar a la vista de datos personales")
                ///router?.navigateToPersonalData()
            case 3:
                print("Navegar a la vista de direcciones")
                wireFrame?.navigateToListAddressView(from: view)
            case 4:
                print("Navegar a la vista de ayuda")
                ///router?.navigateToHelp()
            case 5:
                print("Cerrar sesión")
                // Aquí podrías llamar un método del interactor o del router
            default:
                print("Índice no manejado")
        }
    }
}

// MARK: - ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
