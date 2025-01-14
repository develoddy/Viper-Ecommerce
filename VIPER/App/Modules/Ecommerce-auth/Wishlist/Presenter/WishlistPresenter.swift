//
//  WishlistPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation

class WishlistPresenter: WishlistPresenterProtocol  {
    
    // MARK: Properties
    weak var view: WishlistViewProtocol?
    var interactor: WishlistInteractorInputProtocol?
    var wireFrame: WishlistWireFrameProtocol?
    
    var destinationAfterLogin: String? = "WishlistPresenter"
    
    var token = Token()
    
    // Modelos de vista actualizados
    var wishlistItems: [WishlistItem] = [] {
        didSet {
            self.view?.updateUIList() // Actualiza la vista cuando cambian los items
        }
    }
    
    var flashSale: DiscountModel? {
        didSet {
            ///self.view?.updateFlashSaleUI() // Actualiza la UI del flash sale
        }
    }
    
    var campaignProducts: [ProductModel] = [] {
        didSet {
            ///self.view?.updateCampaignProductsUI() // Actualiza la UI de los productos de la campaña
        }
    }
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.checkUserAuthentication()
    }
    
    func numberOfItems() -> Int {
        return wishlistItems.count // Devuelve el número de items en la wishlist
    }
    
    func getItem(at index: Int) -> WishlistItem? {
        guard index < wishlistItems.count else { return nil }
        return wishlistItems[index] // Devuelve el item correspondiente al índice
    }
    
    func numberOfCampaignProducts() -> Int {
        return campaignProducts.count // Devuelve el número de productos en la campaña
    }
    
    func getCampaignProduct(at index: Int) -> ProductModel? {
        guard index < campaignProducts.count else { return nil }
        return campaignProducts[index] // Devuelve el producto de campaña correspondiente al índice
    }
    
    // Método para navegar a los detalles del producto
    func didSelectProduct(at index: Int) {
        guard let item = getItem(at: index) else { return }
        wireFrame?.navigateToProductDetail(from: view, with: item.product.id, slug: item.product.slug, discountId: 0)
        ///wireFrame?.navigateToProductDetail(from: view, with: item) // Navega a la vista de detalles
    }
}

// MARK: - WishlistInteractorOutputProtocol
extension WishlistPresenter: WishlistInteractorOutputProtocol {
   
    // TODO: implement interactor output methods
    
    func didRetrieveWishlist(_ wishlistResponse: WishlistResponse) {
        // Procesar la respuesta y actualizar los items de la wishlist
        wishlistItems = wishlistResponse.wishlists // Actualiza la lista de deseos
        flashSale = wishlistResponse.flashSale // Actualiza la información del flash sale
        campaignProducts = wishlistResponse.campaignProducts // Actualiza la lista de productos de campaña
        
        //view?.stopActivity() // Detener indicador de carga
        view?.updateUIList() // Actualizar la interfaz de usuario
    }
    
    func didFailToRetrieveWishlist(with error: Error) {
        ///view?.stopActivity() // Detener indicador de carga
        view?.onError(error) // Mostrar el error en la vista
    }
    
    func didFailToAuthenticateUser() {
        // Aquí puedes gestionar la redirección al login
        wireFrame?.navigateToLogin(from: view) // Asegúrate de que esta función esté implementada en el router
    }
}
