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
    
    // MARK: - Modelo de vista actualizado
    var viewModel: ProductDetailRenderViewModel = ProductDetailRenderViewModel(
        product: ProductModel(id: 0, idProduct: "", title: "", slug: "", sku: "", priceSoles: 0.0, priceUsd: 0.0, imagen: "", state: 0, stock: 0, description: "", resumen: "", tags: [], typeInventario: 0, category: CategorieModel(id: 0, title: "", imagen: "", state: 0), galerias: []),
        relatedProducts: [],
        saleFlash: DiscountModel(id: 0, typeCampaign: 0, typeDiscount: 0, discount: 0, startDate: "", endDate: "", startDateNum: 1704067200000, endDateNum: 1706745600000, state: 0, typeSegment: 0),
        reviews: [],
        avgReview: 0.0,
        countReview: 0
    ) {
        didSet {
            self.view?.updateUIList()
        }
    }
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        
        //view?.updateUI(with: viewModel.product) // Pasar los datos del producto a la vista
        
        //print("ProductDetailPresenter - viewDidLoad: productId: \(String(describing: productId)), slug: \(String(describing: slug)), discountId: \(String(describing: discountId))")
               
       // Llama al interactor para obtener los detalles del producto
       if let productId = productId, let slug = slug {
           interactor?.fetchProductDetails(with: productId, with: slug, with: discountId) //fetchProductDetails(by: productId)
       }
    }
    
    func geProduct() -> ProductModel? {
        return viewModel.product
    }
    
    func getRelatedProducts() -> [ProductModel]? {
        return viewModel.relatedProducts
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.product.galerias?.count ?? 0 // Número de categorías
        case 1:
            return viewModel.relatedProducts.count // Número de productos
        default:
            return 0
        }
    }
    
    func getItem(at index: Int, in section: Int) -> ProductDetailRenderType? {
        switch section {
        case 0: // Sección de categorías
            guard index < viewModel.product.galerias?.count ?? 0 else { return nil }
            return ProductDetailRenderType.product(provider: viewModel.product) ///HomeRenderType.categories(provider: viewModel.categories[index])
        case 1: // Sección de productos
            guard index < viewModel.relatedProducts.count else { return nil }
            return ProductDetailRenderType.relatedProducts(provider: viewModel.relatedProducts[index])  ///HomeRenderType.produtcs(provider: viewModel.ourProducts[index])
        default:
            return nil
        }
    }
}

// MARK: - ProductDetailInteractorOutputProtocol
extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    
    // TODO: implement interactor output methods
    func didFetchProductDetails(with productDetailRenderViewModel: ProductDetailRenderViewModel) {
        viewModel = productDetailRenderViewModel
    }
    
    /// Manejo de errores (opcional)
    // Manejo de errores opcional
    //func didFailFetchingProductDetails(with error: Error) {
    //        view?.showErrorMessage("No se pudo cargar la información del producto.") // Mostrar un mensaje de error en la vista
    //    }
}
