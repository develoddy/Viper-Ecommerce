//
//  APIServiceProtocol.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

protocol APIServiceProtocol {
    func login(email: String?, password: String?, completion: @escaping (Result<LoginResponse, Error>) -> Void)
    func fetchList(timeNow: Int, token: String?, completion: @escaping (Result<HomeListResponse, Error>) -> Void) // Agrega este método
    func fetchProductDetails(productId: Int, slug:String, discountId:Int?, completion: @escaping (Result<ProductDetailResponse, Error>) -> Void)
    func fetchWishlist(userId: Int, timeNow: Int, token: String?, completion: @escaping (Result<WishlistResponse, Error>) -> Void)
    
    //func fetchUsers(completion: @escaping (Result<[UserModel], Error>) -> Void)
    //func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void)
    //func fetchCategories(completion: @escaping (Result<[CategorieModel], Error>) -> Void)
}
