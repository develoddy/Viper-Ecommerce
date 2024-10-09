//
//  HomeWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation
import UIKit

class HomeWireFrame: HomeWireFrameProtocol {
   
    

    class func createHomeModule() -> UIViewController {
        
        let homeView = HomeView()
        let viewController = homeView
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
        let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
        let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
        let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
        
        viewController.presenter                = presenter
        presenter.view                          = viewController
        presenter.wireFrame                     = wireFrame
        presenter.interactor                    = interactor
        interactor.presenter                    = presenter
        interactor.localDatamanager             = localDataManager
        interactor.remoteDatamanager            = remoteDataManager
        remoteDataManager.remoteRequestHandler  = interactor
        
        return viewController
    }
    
    func navigateToFilterOptionsView() {
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
    }
    
    
    func navigateToProductDetail(from view: HomeViewProtocol, with product: ProductModel) {
        // Crear la vista de detalles del producto
        let productDetailVC = ProductDetailWireFrame.createProductDetailModule(product: product)
        //productDetailVC.product = product // Configura el producto en el controlador

        // Obtener la escena activa
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }),
           var topController = window.rootViewController {
            
            // Asegúrate de que el controlador superior sea un UINavigationController
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            // Si tienes un UINavigationController, navega usando él
            if let navigationController = topController as? UINavigationController {
                navigationController.pushViewController(productDetailVC, animated: true)
            } else {
                // Si no es un UINavigationController, presenta el ProductDetailViewController de otra forma
                topController.present(productDetailVC, animated: true, completion: nil)
            }
        }
    }

    
}
