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
    
    
    func navigateToProductDetail(from view: HomeViewProtocol?, with productId: Int, slug: String, discountId: Int?) {
        
        guard let discountId = discountId else { return }
        
        // Crear la vista de detalles del producto
        let productDetailVC = ProductDetailWireFrame.createProductDetailModule(productId: productId, slug: slug, discountId: discountId)
        
        // Verificar que la vista (view) sea un controlador de vista válido
        if let viewController = view as? UIViewController {
            
            // Personalizar el botón "Back" para el controlador anterior
            let backItem = UIBarButtonItem()
            backItem.title = ""  // Quitar el texto
            viewController.navigationItem.backBarButtonItem = backItem
            
            // Cambiar el color de la flecha de "Back" a negro
            viewController.navigationController?.navigationBar.tintColor = .black
            
            // Si está dentro de un UINavigationController, usar el push para navegar
            if let navigationController = viewController.navigationController {
                navigationController.pushViewController(productDetailVC, animated: true)
            } else {
                // Si no está dentro de un UINavigationController, presentar el controlador de detalles del producto
                productDetailVC.modalPresentationStyle = .fullScreen
                viewController.present(productDetailVC, animated: true, completion: nil)
            }
        }
    }

    /**func navigateToProductDetail(from view: HomeViewProtocol?, with productId: Int, slug: String, discountId: Int?) {
        guard let discountId = discountId else { return }

        // Crear la vista de detalles del producto
        let productDetailVC = ProductDetailWireFrame.createProductDetailModule(productId: productId, slug: slug, discountId: discountId)
        ///productDetailVC.product = product // Configura el producto en el controlador
        
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
                productDetailVC.modalPresentationStyle = .fullScreen
                topController.present(productDetailVC, animated: true, completion: nil)
            }
        }
    }*/
}
