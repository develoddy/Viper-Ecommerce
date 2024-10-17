//
//  CartPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class CartPresenter: CartPresenterProtocol  {

    // MARK: Properties
    weak var view: CartViewProtocol?
    var interactor: CartInteractorInputProtocol?
    var wireFrame: CartWireFrameProtocol?
    
    var cartsItems: [CartAPIResponse] = [] {
        didSet {
            self.view?.updateUIList() // Actualiza la vista cuando cambian los items
        }
    }
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.checkUserAuthentication()
    }
    
    func numberOfItems() -> Int {
        return cartsItems.count // Devuelve el número de items en la wishlist
    }
    
    func getItem(at index: Int) -> CartAPIResponse? {
        guard index < cartsItems.count else { return nil }
        return cartsItems[index] // Devuelve el item correspondiente al índice
    }
    
    // Método para navegar por ejemplo
    func didSelectProduct(at index: Int) {
        ///guard let item = getItem(at: index) else { return }
        ///wireFrame?.navigateToProductDetail(from: view, with: item.product.id, slug: item.product.slug, discountId: 0)
        ///wireFrame?.navigateToProductDetail(from: view, with: item) // Navega a la vista de detalles
    }
    
}

// MARK: - CartInteractorOutputProtocol
extension CartPresenter: CartInteractorOutputProtocol {

    // TODO: implement interactor output methods
    func didRetrieveCarts(_ cartstResponse: CartsAPIResponse) {
        cartsItems = cartstResponse.carts
        view?.updateFooter(with: cartstResponse)
    }
    
    func didFailToRetrieveCarts(with error: Error) {
        // llamar a la vista
    }
    
    func didFailToAuthenticateUser() {
        // Aquí puedes gestionar la redirección al login
        wireFrame?.navigateToLogin(from: view) // Asegúrate de que esta función esté implementada en el router
    }
    
}
