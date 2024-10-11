//
//  ProductDetailRenderType.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//

import Foundation
enum ProductDetailRenderType {
    case product(provider: ProductModel)
    case relatedProducts(provider: ProductModel)
    case saleFlash(provider: DiscountModel)
    case reviews(provider: ReviewModel)
    case avgReview(value: Double)
    case countReview(value: Int)
}
