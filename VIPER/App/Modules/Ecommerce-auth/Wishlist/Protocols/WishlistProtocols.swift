//
//  WishlistProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation
import UIKit

protocol WishlistViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: WishlistPresenterProtocol? { get set }
    func updateUIList()
    func onError(_ error: Error)
}

protocol WishlistWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createWishlistModule() -> UIViewController
    func navigateToProductDetail(from view: WishlistViewProtocol?, with productId: Int, slug: String, discountId: Int?)
    func navigateToLogin(from view: WishlistViewProtocol?)
}

protocol WishlistPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: WishlistViewProtocol? { get set }
    var interactor: WishlistInteractorInputProtocol? { get set }
    var wireFrame: WishlistWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func getItem(at index: Int) -> WishlistItem?
    func numberOfCampaignProducts() -> Int
    func getCampaignProduct(at index: Int) -> ProductModel?
    func didSelectProduct(at index: Int)
}

protocol WishlistInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrieveWishlist(_ wishlistResponse: WishlistResponse)
    func didFailToRetrieveWishlist(with error: Error)
    func didFailToAuthenticateUser() 
}

protocol WishlistInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: WishlistInteractorOutputProtocol? { get set }
    var localDatamanager: WishlistLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: WishlistRemoteDataManagerInputProtocol? { get set }
    
    func checkUserAuthentication()
    func fetchWishlists(with userId: Int, with token: String)
}

protocol WishlistDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol WishlistRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: WishlistRemoteDataManagerOutputProtocol? { get set }
    func fetchWishlists(with userId: Int, with token: String)
}

protocol WishlistRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onWishlistRetrieved(with wishlistResponse: WishlistResponse)
    func onError(_ error: Error)
}

protocol WishlistLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
