//
//  HomeInteractor.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation

// MARK: HOME INTERACTOR
class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: - PROPERTIES
    weak var presenter: HomeInteractorOutputProtocol?
    var localDatamanager: HomeLocalDataManagerInputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    private var product: ProductModel?
    
    // DECIRLE A LA CAPA DE CONEXIÓN EXTERNA (EXTERNALDATAMANEGER) QUE TIENE QUE TRAER UNOS DATOS
    func interactorGetData(token: String) {
        remoteDatamanager?.remoteGetData(token: token)
    }
    
    func fetchProductDetails(with id: Int) {
        remoteDatamanager?.fetchProductDetails(with: id)
    }
}


// MARK: - OUTPUT REMOTE MANAGER PROTOCOL
extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
   
    // EL INTERACTOR DEBE ENVIARLE LOS DATOS AL PRESENTER BIEN "MASTICADITO"
    // Función que recibe los datos del remote data manager
    func remoteCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel) {
        ///Por ejemplo, si necesitas filtrar, ordenar o transformar los datos antes de enviarlos al presenter.
        ///print("===> Soy el HomeInteractor : Items recibidos del remote data manager: \(homeFeedRenderViewModel.items)")
        // Aquí puedes hacer alguna manipulación o filtrado si es necesario
        /// Nota: Lo de stock hay que revisar tanto en el backend como en este bloque
        ///let filteredItems = homeFeedRenderViewModel.items.filter {
        ///    if case let .product(provider) = $0 {
        ///        if let stock = provider.stock { // Desenvuelve el opcional
        ///            return stock > 0
        ///        }
        ///    }
        ///    return false
        ///}
        ///
        
        // Crear un nuevo modelo de vista con los ítems filtrados
        let filteredViewModel = HomeFeedRenderViewModel(
            categories: homeFeedRenderViewModel.categories, // Incluye categorías
            sliders: homeFeedRenderViewModel.sliders, // Incluye sliders
            ourProducts: homeFeedRenderViewModel.ourProducts,
            bestProducts: homeFeedRenderViewModel.bestProducts // Incluye mejores productos
        )
        presenter?.interactorCallBackData(with: filteredViewModel)
    }
    
    
    func remoteFetchProductDetailsBackData(product: ProductModel) {
        // Aquí notificas al presenter que tienes el producto
        presenter?.didFetchProductDetails(product: product)
    }
}
