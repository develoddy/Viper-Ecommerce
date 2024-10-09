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
    let apiService: APIServiceProtocol
    
    // The collection that will contain our fetched data
    var models: [HomeFeedRenderViewModel] = []
  
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceProtocol = APIService()) {
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
    func fetchProductDetails(with id: Int) {
        ///remoteRequestHandler?.remoteFetchProductDetailsBackData()
    
        /*apiService.fetchProductDetails(id: id) { result in
            switch result {
            case .success(let productResponse):
                // Supongamos que tienes un modelo ProductModel para el producto
                let product = ProductModel(id: productResponse.id, name: productResponse.title , price: productResponse.priceUsd, description: productResponse.description)
                
                remoteRequestHandler?.remoteFetchProductDetailsBackData(product: product)

            case .failure(let error):
                // Manejo de error
                print("Error fetching product details: \(error.localizedDescription)")
            }
        }*/
    }
}
