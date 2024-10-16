//
//  ProductDetailRenderViewModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 9/10/24.
//

import Foundation

struct ProductDetailRenderViewModel {
    let product: ProductModel
    let relatedProducts: [ProductModel]
    let saleFlash: DiscountModel?
    let reviews: [ReviewModel]
    let avgReview: Double
    let countReview: Int
    
    // Aquí generamos los items de renderizado de manera similar a HomeFeedRenderViewModel
    var renderItems: [ProductDetailRenderType] {
        var items: [ProductDetailRenderType] = []
        
        // Producto principal
        items.append(.product(provider: product))
        
        // Productos relacionados
        items.append(contentsOf: relatedProducts.map { ProductDetailRenderType.relatedProducts(provider: $0) })
        
        // Flash de oferta (si existe)
        ///items.append(.saleFlash(provider: saleFlash))
        // Flash de oferta (si existe)
        if let saleFlash = saleFlash {
            items.append(.saleFlash(provider: saleFlash))  // Solo se agrega si no es nil
        }
        
        // Reseñas
        items.append(contentsOf: reviews.map { ProductDetailRenderType.reviews(provider: $0) })
        
        // Promedio de reseñas
        items.append(.avgReview(value: avgReview))
        
        // Número de reseñas
        items.append(.countReview(value: countReview))
        
        return items
    }
}
