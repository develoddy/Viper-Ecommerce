//
//  ListAddressPresenter.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation

class ListAddressPresenter: ListAddressPresenterProtocol {

    // MARK: Properties
    weak var view: ListAddressViewProtocol?
    var interactor: ListAddressInteractorInputProtocol?
    var wireFrame: ListAddressWireFrameProtocol?
    
    var saleAddressItems: [SaleAddressModel] = [] {
        didSet {
            self.view?.updateUIList() // Actualiza la vista cuando cambian los items
        }
    }
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.fetchSaleAddress()
    }
    
    func numberOfItems() -> Int {
        return saleAddressItems.count // Devuelve el número de items en la wishlist
    }
    
    func getItem(at index: Int) -> SaleAddressModel? {
        guard index < saleAddressItems.count else { return nil }
        return saleAddressItems[index] // Devuelve el item correspondiente al índice
    }
    
    func didSelect(at index: Int) {
        guard let item = getItem(at: index) else { return }
    }
}

extension ListAddressPresenter: ListAddressInteractorOutputProtocol {
    func didRetrieveListAddress(_ saleAddressResponse: SaleAddressResponse) {
        // Procesar la respuesta y actualizar los items de ListAddress
        print("===> [Presenter] SaleAddressResponse Respuesta completa del API: \(saleAddressResponse)")
        saleAddressItems = saleAddressResponse.addressClient
        view?.updateUIList() // Actualizar la interfaz de usuario
    }
    
    func didFailToRetrieveListAddress(with error: Error) {
        view?.onError(error) // Mostrar el error en la vista
    }
    
}
