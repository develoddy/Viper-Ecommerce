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
    
    // MARK: - PROPERTIES
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


// MARK: - HOME PRESENT PROTOCOL >
extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        // Llamar al interactor
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
    
    
    // EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE ENVIA EL INTERACTOR
    func interactorCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel) {
        ///viewModel = homeFeedRenderViewModel
        ourProducts = homeFeedRenderViewModel.ourProducts
        // Aqui puedes seguir asignado los datos del api en una variable
        ///categories = homeFeedRenderViewModel.categories
        ///besProducts = homeFeedRenderViewModel.bestProducts
        view?.stopActivity()
        view?.updateUIList()
    }
    
    func didFetchProductDetails(with productDetailRenderViewModel: ProductDetailRenderViewModel) {
        
        print("===> HomePresenter Respuesta completa del Interactor: \(productDetailRenderViewModel)")
        // Aquí llamas al wireframe para navegar a la vista de detalles del producto
        /*if let view = view {
            wireFrame?.navigateToProductDetail(from: view, with: product)
        } else {
            print("Error: la vista es nil, no se puede navegar.")
        }*/
    }
    
    func didFailToRetrieveWishlist(with error: Error) {
        ///view?.stopActivity() // Detener indicador de carga
        view?.onError(error) // Mostrar el error en la vista
        
    }
    
}
