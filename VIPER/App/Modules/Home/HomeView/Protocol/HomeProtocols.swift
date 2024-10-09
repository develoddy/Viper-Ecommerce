//
//  HomeProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: HomePresenterProtocol? { get set }
    
    func updateUIList()
    func startActivity()
    func stopActivity() 
}

protocol HomeWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createHomeModule() -> UIViewController
    func navigateToFilterOptionsView()
    func navigateToProductDetail(from: HomeViewProtocol, with: ProductModel)
}

protocol HomePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
        
    func viewDidLoad()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getItem(at index: Int, in section: Int) -> HomeRenderType?
    
    func filterOptions()
    func didSelectProduct(at index: Int)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel) // Cambiado a HomeFeedRenderViewModel
    func didFetchProductDetails(product: ProductModel)
}

protocol HomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    // FUNCIÓN QUE PERMITE AL INTERACTOR GESTIONAR DATOS CON LA EJECUCIÓN DE ESTA FUNCIÓN DESDE EL PRESENTER
    func interactorGetData(token: String)
    func fetchProductDetails(with id: Int)
}

protocol HomeDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData(token: String)
    func fetchProductDetails(with id: Int)
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel) // Cambiado a HomeFeedRenderViewModel
    func remoteFetchProductDetailsBackData(product: ProductModel)
}

protocol HomeLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
