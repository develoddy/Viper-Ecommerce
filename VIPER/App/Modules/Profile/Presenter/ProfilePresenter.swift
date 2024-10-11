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
    
}

// MARK: - ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
