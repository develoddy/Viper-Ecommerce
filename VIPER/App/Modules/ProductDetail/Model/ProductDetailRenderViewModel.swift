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
    let saleFlash: String?
    let reviews: [ReviewModel]
    let avgReview: Double
    let countReview: Int
}
