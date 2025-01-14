//
//  HomePresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

// MARK: PRESENTER
class HomePresenter  {
    
    // MARK: - Prperties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
    // MARK: - Closures
    var ourProducts: [ProductModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }
}

// MARK: - HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        self.interactor?.interactorGetData()
        view?.startActivity()
    }
    
    func numberOfItems() -> Int {
        return ourProducts.count // Devuelve el número de items en los productos
    }
    
    func getItem(at index: Int) -> ProductModel? {
        guard index < ourProducts.count else { return nil }
        return ourProducts[index] // Devuelve el item correspondiente al índice
    }
    
    // Método para navegar a los detalles del producto
    func didSelectProduct(at index: Int, at discountId: Int) {
        guard let item = getItem(at: index) else { return }
        
        if let id = item.id, let slug = item.slug  {
            wireFrame?.navigateToProductDetail(from: view, with: id, slug: slug, discountId: discountId)
        }
    }
    
    func filterOptions() {
        wireFrame?.navigateToFilterOptionsView()
    }
}

// MARK: - OUTPUT HOME INTERACTOR PROTOCOL
extension HomePresenter: HomeInteractorOutputProtocol {
    func interactorCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel) {
        ourProducts = homeFeedRenderViewModel.ourProducts
        view?.stopActivity()
        view?.updateUIList()
    }
    
    func didFailToRetrieveWishlist(with error: Error) {
        view?.onError(error)
    }
    
    func didFetchProductDetails(with productDetailRenderViewModel: ProductDetailRenderViewModel) {
    }
}
