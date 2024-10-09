//
//  ProductDetailView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

class ProductDetailView: UIViewController {

    // MARK: Properties
    var presenter: ProductDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = "Detalle del producto"
        view.backgroundColor = .systemCyan
        presenter?.viewDidLoad()
    }
}

extension ProductDetailView: ProductDetailViewProtocol {
    // TODO: implement view output methods
}
