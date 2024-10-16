//
//  CartRemoteDataManager.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation

class CartRemoteDataManager:CartRemoteDataManagerInputProtocol {

    var remoteRequestHandler: CartRemoteDataManagerOutputProtocol?
    
    let apiService: APIServiceCartProtocol
    
    // MARK: - CONSTRUCTOR
    init(apiService: APIServiceCartProtocol = APIServiceCart()) {
        self.apiService = apiService
    }
    
    /*
     listAllCarts() {
         this._cartService.resetCart();
         if ( this._cartService._authService.user ) {
           this._cartService.listCarts(this.userId).subscribe((resp:any) => {
             resp.carts.forEach((cart:any) => {
               this._cartService.changeCart(cart);
             });
           });
         }
       }
     */
    
    //private var token = Token()
    
    // Buscar productos en el carrito en la base de datos
    /// Hay que enviar el ID del usuario
    /// Hay que enviar el token del usuario autenticado
   
    func fetchCarts(with userId: Int) {
        
        // Llama a la función fetchCarts en el apiService
        apiService.fetchCarts(userId: userId) { result in
            switch result {
            case .success(let cartResponse): 
                ///print("---- CartRemoteDataManager API COMPLETA CART: \(cartResponse)")
                // Notificar al interactor con los datos obtenidos
                self.remoteRequestHandler?.onCartsRetrieved(with: cartResponse)
                
            case .failure(let error):
                // Maneja el error de manera adecuada
                print("Error fetching carts: \(error.localizedDescription)")
                // Notifica al interactor sobre el error
                self.remoteRequestHandler?.onError(error)
            }
        }
    }

    
    
}
