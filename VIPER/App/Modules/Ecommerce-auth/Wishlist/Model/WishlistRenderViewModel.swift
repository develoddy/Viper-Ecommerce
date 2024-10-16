//
//  WishlistRenderViewModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import Foundation

struct WishlistRenderViewModel {
    let wishlistItems: [WishlistItem]
    let flashSale: DiscountModel?
    let campaignProducts: [ProductModel]

    var renderItems: [WishlistRenderType] {
        var items: [WishlistRenderType] = []
        
        // Agrega los artículos de la wishlist
        items.append(contentsOf: wishlistItems.map { WishlistRenderType.wishlistItem(provider: $0) })
        
        // Agrega la oferta flash si existe
        if let flashSale = flashSale {
            items.append(WishlistRenderType.flashSale(provider: flashSale))
        }

        // Agrega los productos de la campaña
        items.append(contentsOf: campaignProducts.map { WishlistRenderType.campaignProduct(provider: $0) })
        
        return items
    }
}

// Definición del tipo WishlistRenderType
enum WishlistRenderType {
    case wishlistItem(provider: WishlistItem)
    case flashSale(provider: DiscountModel)
    case campaignProduct(provider: ProductModel)
}
