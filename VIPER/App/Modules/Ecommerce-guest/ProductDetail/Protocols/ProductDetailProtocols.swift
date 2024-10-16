//
//  ProductDetailProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ProductDetailPresenterProtocol? { get set }
    func updateUIList()
    //func updateUI(with product: ProductModel)
    func startActivity()
    func stopActivity() 
    
}

protocol ProductDetailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createProductDetailModule(productId: Int, slug: String, discountId: Int) -> UIViewController
}

protocol ProductDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ProductDetailViewProtocol? { get set }
    var interactor: ProductDetailInteractorInputProtocol? { get set }
    var wireFrame: ProductDetailWireFrameProtocol? { get set }
    var productId: Int? { get set }
    var slug: String? { get set }
    var discountId: Int? { get set }

    func viewDidLoad()
    func geProduct() -> ProductModel?
    func getRelatedProducts() -> [ProductModel]?
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func getItem(at index: Int, in section: Int) -> ProductDetailRenderType?
    
    /**func getRenderViewModel() -> ProductDetailRenderViewModel?
    func getProduct() -> ProductModel?
    func getRelatedProducts() -> [ProductModel]?
    func getThumbnails() -> [GaleriaModel]*/
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didFetchProductDetails(with productDetailRenderViewModel: ProductDetailRenderViewModel)
}

protocol ProductDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ProductDetailInteractorOutputProtocol? { get set }
    var localDatamanager: ProductDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProductDetailRemoteDataManagerInputProtocol? { get set }
    func fetchProductDetails(with productId: Int, with slug:String, with discountId: Int?)
}

protocol ProductDetailDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProductDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProductDetailRemoteDataManagerOutputProtocol? { get set }
    func fetchProductDetails(with productId: Int, with slug:String, with discountId: Int?)
}

protocol ProductDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteFetchProductDetailsBackData(with productDetailRenderViewModel: ProductDetailRenderViewModel)
}

protocol ProductDetailLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
