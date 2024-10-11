//
//  ProductDetailRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation

class ProductDetailRemoteDataManager:ProductDetailRemoteDataManagerInputProtocol {

    var remoteRequestHandler: ProductDetailRemoteDataManagerOutputProtocol?
    
    let apiService: APIServiceProtocol
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchProductDetails(with productId: Int, with slug: String, with discountId: Int?) {
        guard let discountId = discountId  else { return }
        
        // Llama a la función fetchProductDetails en el apiService
        //apiService.fetchProductDetails(with: productId, slug: slug, discountId: discountId) { result in
        apiService.fetchProductDetails(productId: productId, slug: slug, discountId: discountId) { result in
        switch result {
            case .success(let productResponse):
                ///print("===> Product details Respuesta completa del API: \(productResponse)")
                // Crear el modelo de vista a partir de la respuesta del producto
                let viewModel = ProductDetailRenderViewModel(
                    product: productResponse.product,
                    relatedProducts: productResponse.related_products,
                    saleFlash: productResponse.SALE_FLASH,
                    reviews: productResponse.REVIEWS,
                    avgReview: productResponse.AVG_REVIEW,
                    countReview: productResponse.COUNT_REVIEW
                )
                
                // Envía el modelo de vista de vuelta al interactor
            self.remoteRequestHandler?.remoteFetchProductDetailsBackData(with: viewModel)

            case .failure(let error):
                // Maneja el error de manera adecuada
                print("Error fetching product details: \(error.localizedDescription)")
                //self.remoteRequestHandler?.remoteCallBackProductDetails(with: nil) // O maneja el error según tu lógica
            }
        }
    }
    
}
