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
    var token = Token()
    
    // MARK: - Closures
    /**var viewModel: [HomeFeedRenderViewModel] = [] {
        didSet {
            self.view?.updateUIList()
        }
    }*/
    
    // Modelo de vista actualizado
    var viewModel = HomeFeedRenderViewModel(categories: [], sliders: [], ourProducts: [], bestProducts: []) {
       didSet {
           self.view?.updateUIList()
       }
    }
}


// MARK: - HOME PRESENT PROTOCOL >
extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        // DECIRLE AL INTERACTOR QUE QUIERE TRAER UNOS DATOS
        guard let token = token.getUserToken().token else { return }
        self.interactor?.interactorGetData(token: token)
        view?.startActivity()
    }
    
    func numberOfSections() -> Int {
        return 2 // Una sección para categorías y otra para productos
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.categories.count // Número de categorías
        case 1:
            return viewModel.ourProducts.count // Número de productos
        default:
            return 0
        }
    }
    
    func getItem(at index: Int, in section: Int) -> HomeRenderType? {
        switch section {
        case 0: // Sección de categorías
            guard index < viewModel.categories.count else { return nil }
            return HomeRenderType.categories(provider: viewModel.categories[index])
        case 1: // Sección de productos
            guard index < viewModel.ourProducts.count else { return nil }
            return HomeRenderType.produtcs(provider: viewModel.ourProducts[index])
        default:
            return nil
        }
    }
    
    func filterOptions() {
        wireFrame?.navigateToFilterOptionsView()
    }
    
    // Pasar datos del producto al interactor
    //func didSelectProduct(at index: Int, at discountId: Int) {
        ///print("DEbbug: Presenter didSelectProduct: me llega el index de produc: \(index)")
        // Obtener el id del producto de viewModel
    //    if let productId = viewModel.ourProducts[index].id, let slug = viewModel.ourProducts[index].slug {
            ///print("DEbbug: Presenter En base al index, obtego el id del producto: \(productId)")
    //        interactor?.fetchProductDetails(with: productId, with: slug, with: discountId) // Llamar al interactor para obtener detalles del producto
    //    } else {
    //        print("Error: El ID del producto es nil")
    //    }
    //}
    
    // Pasar datos del producto al módulo de detalle
    func didSelectProduct(at index: Int, at discountId: Int) {
        if let productId = viewModel.ourProducts[index].id, let slug = viewModel.ourProducts[index].slug {
            // Llamar al wireframe para navegar a la vista de detalle del producto
            //wireFrame?.navigateToDetailProduct(from: view, with: productId, slug: slug, discountId: discountId)
            wireFrame?.navigateToProductDetail(from: view, with: productId, slug: slug, discountId: discountId)
        } else {
            print("Error: El ID del producto es nil")
        }
    }
}

// MARK: - OUTPUT HOME INTERACTOR PROTOCOL
extension HomePresenter: HomeInteractorOutputProtocol {
    
    
    // EL PRESENTER RECIBE EL ARRAY DE OBJETOS QUE ENVIA EL INTERACTOR
    func interactorCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel) {
        viewModel = homeFeedRenderViewModel
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
    
}
