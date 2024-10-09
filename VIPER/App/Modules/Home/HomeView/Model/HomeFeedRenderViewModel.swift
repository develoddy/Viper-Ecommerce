//
//  HomeFeedRenderViewModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation
/*struct HomeFeedRenderViewModel {
    let items: [HomeRenderType] // Usamos un array de HomeRenderType para manejar el encabezado, productos y pie de página
}*/

struct HomeFeedRenderViewModel {
    ///let items: [HomeRenderType]
    let categories: [CategorieModel] // Agrega esta línea
    let sliders: [SliderModel] // Si tienes un modelo para sliders
    let ourProducts: [ProductModel]
    let bestProducts: [ProductModel] // Si necesitas los mejores productos
    
    var renderItems: [HomeRenderType] {
        var items: [HomeRenderType] = []
        items.append(contentsOf: categories.map { HomeRenderType.categories(provider: $0) })
        items.append(contentsOf: ourProducts.map { HomeRenderType.produtcs(provider: $0) })
        // Si también deseas incluir los mejores productos o sliders, hazlo aquí.
        return items
    }
}

