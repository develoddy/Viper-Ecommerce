//
//  ProductDetailPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    // MARK: Properties
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorInputProtocol?
    var wireFrame: ProductDetailWireFrameProtocol?
    /// Propiedades & datosque llegan del modulo HomeView
    var productId: Int?
    var slug: String?
    var discountId: Int?
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        print("ProductDetailPresenter - viewDidLoad: productId: \(String(describing: productId)), slug: \(String(describing: slug)), discountId: \(String(describing: discountId))")
    }
}


extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
