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
    func navigateToProductDetail(from view: HomeViewProtocol?, with productId: Int, slug: String, discountId: Int?)
    
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
    func didSelectProduct(at index: Int, at discountId: Int)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func interactorCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel)
    func didFetchProductDetails(with productDetailRenderViewModel: ProductDetailRenderViewModel)
}

protocol HomeInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
    // FUNCIÓN QUE PERMITE AL INTERACTOR GESTIONAR DATOS CON LA EJECUCIÓN DE ESTA FUNCIÓN DESDE EL PRESENTER
    func interactorGetData()
    func fetchProductDetails(with productId: Int, with slug:String, with discountId: Int?)
}

protocol HomeDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func remoteGetData()
    func fetchProductDetails(with productId: Int, with slug:String, with discountId: Int?)
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteCallBackData(with homeFeedRenderViewModel: HomeFeedRenderViewModel)
    func remoteFetchProductDetailsBackData(with productDetailRenderViewModel: ProductDetailRenderViewModel)
}

protocol HomeLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
