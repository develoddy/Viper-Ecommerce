//
//  ListResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct HomeListResponse: Codable {
    let sliders: [SliderModel]
    let categories: [CategorieModel] // Necesitas definir CategoryModel
    let bestProducts: [ProductModel] // Necesitas definir ProductModel
    let ourProducts: [ProductModel] // Necesitas definir ProductModel
    let flashSale: DiscountModel? // Necesitas definir FlashSaleModel (esta propiedad 'FlashSaleModel' tiene el backend de nodejs)
    let campaignProducts: [ProductModel] // Necesitas definir ProductModel

    enum CodingKeys: String, CodingKey {
        case sliders
        case categories
        case bestProducts = "bes_products"
        case ourProducts = "our_products"
        case flashSale
        case campaignProducts = "campaign_products"
    }
}
