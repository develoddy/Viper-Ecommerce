//
//  HomeRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    // MARK: - PROPIERTIES
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    // We defined the FakeAPIServiceProtocol in the APIService.swift file.
    let apiService: APIServiceEcommerceGuestPrtocol
    
    // The collection that will contain our fetched data
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceEcommerceGuestPrtocol = APIServiceEcommerceGuest()) {
        self.apiService = apiService
    }
    
    
    // MARK: - FUNCTIONS
    
    // GET DATA
    func remoteGetData(token: String) {
        
        // Define el tiempo actual
        let timeNow = Int(Date().timeIntervalSince1970)

        // Llama a la función fetchList en el apiService
        apiService.fetchList(timeNow: timeNow, token: token) { result in
            switch result {
                case .success(let homeListResponse):
                    ///print("===> HomeRemote Respuesta completa del API: \(homeListResponse)")
                    //Crear el modelo de vista y enviarlo de vuelta al interactor
                    let viewModel = HomeFeedRenderViewModel(
                        categories: homeListResponse.categories, // Agrega categorías
                        sliders: homeListResponse.sliders, // Si tienes un modelo para sliders
                        ourProducts: homeListResponse.ourProducts,
                        bestProducts: homeListResponse.bestProducts
                    )
                    
                    self.remoteRequestHandler?.remoteCallBackData(with: viewModel)

                case .failure(let error):
                    // Maneja el error de manera adecuada
                    print("Error fetching data: \(error.localizedDescription)") // Imprime el error
                    //self.remoteRequestHandler?.remoteCallBackData(with: nil) // O maneja el error según tu lógica
                }
        }
    }
    
    // Método para obtener un producto específico (podría ser por ID, por ejemplo)
    func fetchProductDetails(with productId: Int, with slug: String, with discountId: Int?) {
        
        //print("--Debbug: HomeRemote: Me llega userId, slug, discountId: \(productId) \(slug) \(discountId)")
        guard let discountId = discountId  else { return }
        
        // Llama a la función fetchProductDetails en el apiService
        //apiService.fetchProductDetails(with: productId, slug: slug, discountId: discountId) { result in
        apiService.fetchProductDetails(productId: productId, slug: slug, discountId: discountId) { result in
        switch result {
            case .success(let productResponse):
                ///print("===> HomeRemote Respuesta completa del API: \(productResponse)")
                // Crear el modelo de vista a partir de la respuesta del producto
                let viewModel = ProductDetailRenderViewModel(
                    product: productResponse.product,
                    relatedProducts: productResponse.related_products,
                    //saleFlash: productResponse.SALE_FLASH,
                    saleFlash: productResponse.SALE_FLASH ?? DiscountModel(id: 0, typeCampaign: 0, typeDiscount: 0, discount: 0, startDate: "", endDate: "", startDateNum: 0, endDateNum: 0, state: 0, typeSegment: 0),  // Valor por defecto si es nil
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
