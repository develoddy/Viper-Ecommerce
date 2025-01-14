//
//  ListAddressProtocols.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

protocol ListAddressViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: ListAddressPresenterProtocol? { get set }
    func updateUIList()
    func onError(_ error: Error)
}

protocol ListAddressWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createListAddressModule() -> UIViewController
}

protocol ListAddressPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: ListAddressViewProtocol? { get set }
    var interactor: ListAddressInteractorInputProtocol? { get set }
    var wireFrame: ListAddressWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func getItem(at index: Int) -> SaleAddressModel?
    func didSelect(at index: Int)
}

protocol ListAddressInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrieveListAddress(_ saleAddressResponse: SaleAddressResponse)
    func didFailToRetrieveListAddress(with error: Error)
}

protocol ListAddressInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: ListAddressInteractorOutputProtocol? { get set }
    var localDatamanager: ListAddressLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ListAddressRemoteDataManagerInputProtocol? { get set }
    func fetchSaleAddress()
}

protocol ListAddressDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ListAddressRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ListAddressRemoteDataManagerOutputProtocol? { get set }
    func fetchSaleAddress(with userId: Int, with token: String)
}

protocol ListAddressRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onListAddressRetrieved(with saleAddressResponse: SaleAddressResponse)
    func onError(_ error: Error)
}

protocol ListAddressLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
