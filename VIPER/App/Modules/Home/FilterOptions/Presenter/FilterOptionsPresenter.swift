//
//  FilterOptionsPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class FilterOptionsPresenter  {
    
    // MARK: Properties
    weak var view: FilterOptionsViewProtocol?
    var interactor: FilterOptionsInteractorInputProtocol?
    var wireFrame: FilterOptionsWireFrameProtocol?
    
}

extension FilterOptionsPresenter: FilterOptionsPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension FilterOptionsPresenter: FilterOptionsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
