//
//  ProductDetailPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class ProductDetailPresenter  {
    
    // MARK: Properties
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorInputProtocol?
    var wireFrame: ProductDetailWireFrameProtocol?
    //var product: ProductModel?
    var product: ProductModel?
    
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
