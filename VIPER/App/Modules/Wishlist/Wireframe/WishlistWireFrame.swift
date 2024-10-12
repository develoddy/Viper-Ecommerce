//
//  WishlistWireFrame.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation
import UIKit

class WishlistWireFrame: WishlistWireFrameProtocol {

    class func createWishlistModule() -> UIViewController {
        
        let wishlistView = WishlistView()
        let viewController = wishlistView
        let presenter: WishlistPresenterProtocol & WishlistInteractorOutputProtocol = WishlistPresenter()
        let interactor: WishlistInteractorInputProtocol & WishlistRemoteDataManagerOutputProtocol = WishlistInteractor()
        let localDataManager: WishlistLocalDataManagerInputProtocol = WishlistLocalDataManager()
        let remoteDataManager: WishlistRemoteDataManagerInputProtocol = WishlistRemoteDataManager()
        let wireFrame: WishlistWireFrameProtocol = WishlistWireFrame()
            
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
}
