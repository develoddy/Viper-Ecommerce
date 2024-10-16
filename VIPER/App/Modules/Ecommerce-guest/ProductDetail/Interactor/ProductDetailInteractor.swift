//
//  ProductDetailInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class ProductDetailInteractor: ProductDetailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ProductDetailInteractorOutputProtocol?
    var localDatamanager: ProductDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: ProductDetailRemoteDataManagerInputProtocol?
    
    func fetchProductDetails(with productId: Int, with slug: String, with discountId: Int?) {
        // Solicita los detalles del producto al remoteDataManager
        remoteDatamanager?.fetchProductDetails(with: productId, with: slug, with: discountId)
    }
}

// MARK: - ProductDetailRemoteDataManagerOutputProtocol
extension ProductDetailInteractor: ProductDetailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    /**
     * Explicación:
     * Filtrado de duplicados: Se crea un array uniqueGalerias y un conjunto seenColors para rastrear los colores que ya se han encontrado. Se recorre el array de galerías y se añaden solo aquellos elementos cuyo color aún no ha sido visto.
     * Actualización del ViewModel: Después de filtrar las galerías, se crea un nuevo ProductDetailRenderViewModel con los datos actualizados, eliminando las galerías duplicadas por color.
     * Envía los datos actualizados al Presenter: Luego, el interactor pasa el nuevo objeto updatedViewModel al presenter.
     */
    func remoteFetchProductDetailsBackData(with productDetailRenderViewModel: ProductDetailRenderViewModel) {
        
        // Eliminar duplicados de galerías en base al color
        var uniqueGalerias: [GaleriaModel] = []
        var seenColors: Set<String> = []
        
        if let galerias = productDetailRenderViewModel.product.galerias {
            for galeria in galerias {
                if let color = galeria.color, !seenColors.contains(color) {
                    uniqueGalerias.append(galeria)
                    seenColors.insert(color)
                }
            }
        }
        
        var updatedProduct = productDetailRenderViewModel.product
        updatedProduct.galerias = uniqueGalerias
        
        let updatedViewModel = ProductDetailRenderViewModel(
            product: updatedProduct,
            relatedProducts: productDetailRenderViewModel.relatedProducts,
            saleFlash: productDetailRenderViewModel.saleFlash,
            reviews: productDetailRenderViewModel.reviews,
            avgReview: productDetailRenderViewModel.avgReview,
            countReview: productDetailRenderViewModel.countReview
        )
        
        // Pasar los datos al presenter
        //print("----> Interactor API COMPLETA \(updatedViewModel)")
        presenter?.didFetchProductDetails(with: updatedViewModel)
    }
}
