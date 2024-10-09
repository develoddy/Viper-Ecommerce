//
//  HomeRenderType.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation
// Enum para los diferentes tipos de celdas en la colección
/*enum HomeRenderType {
    case header(provider: String)
    case product(provider: ProductModel) // Cambiamos esto para incluir un modelo de producto
    case footer(provider: String)
}*/


enum HomeRenderType {
    case categories(provider: CategorieModel)
    case produtcs(provider: ProductModel)
}




