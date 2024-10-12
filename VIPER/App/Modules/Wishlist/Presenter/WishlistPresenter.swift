//
//  WishlistPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation

class WishlistPresenter  {
    
    // MARK: Properties
    weak var view: WishlistViewProtocol?
    var interactor: WishlistInteractorInputProtocol?
    var wireFrame: WishlistWireFrameProtocol?
    
}

extension WishlistPresenter: WishlistPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension WishlistPresenter: WishlistInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
