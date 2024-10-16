//
//  ProductDetailWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

class ProductDetailWireFrame: ProductDetailWireFrameProtocol {
    
    static func createProductDetailModule(productId: Int, slug: String, discountId: Int) -> UIViewController {
        
        let productDetailView = ProductDetailView()
        let viewController = productDetailView
        let presenter: ProductDetailPresenterProtocol & ProductDetailInteractorOutputProtocol = ProductDetailPresenter()
        let interactor: ProductDetailInteractorInputProtocol & ProductDetailRemoteDataManagerOutputProtocol = ProductDetailInteractor()
        let localDataManager: ProductDetailLocalDataManagerInputProtocol = ProductDetailLocalDataManager()
        let remoteDataManager: ProductDetailRemoteDataManagerInputProtocol = ProductDetailRemoteDataManager()
        let wireFrame: ProductDetailWireFrameProtocol = ProductDetailWireFrame()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        /// Propiedades & datosque llegan del modulo HomeView
        presenter.productId = productId
        presenter.slug = slug
        presenter.discountId = discountId
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
    /**func navigateToView() {
        let filterOptionsViewController = FilterOptionsWireFrame.createFilterOptionsModule()
        
        // Obtén la escena activa
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }),
           let topController = window.rootViewController {
            
            // Si tienes un UINavigationController, navega usando él
            if let navigationController = topController as? UINavigationController {
                navigationController.pushViewController(filterOptionsViewController, animated: true)
            } else {
                // Si no es un UINavigationController, presenta el FilterOptionsViewController de otra forma
                topController.present(filterOptionsViewController, animated: true, completion: nil)
            }
        }
    }*/
    
}
