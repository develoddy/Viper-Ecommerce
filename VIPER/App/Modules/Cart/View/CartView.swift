//
//  CartView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation
import UIKit

class CartView: UIViewController {

    // MARK: Properties
    var presenter: CartPresenterProtocol?
    
    private let cartFooterView = CartFooterView()
    
    private let cartItemsCollectionView = CartItemsCollectionView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        title = "Carrito de compra"
        view.backgroundColor = .systemGray
        
        // Añadir subviews
        view.addSubview(cartItemsCollectionView)
        view.addSubview(cartFooterView)
        
        // Configurar restricciones
        setupConstraints()
        configureCollections()
    }
    
    private func setupConstraints() {
        cartItemsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // CartItemsCollectionView constraints
            cartItemsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartItemsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartItemsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartItemsCollectionView.bottomAnchor.constraint(equalTo: cartFooterView.topAnchor),
            
            // CartFooterView constraints
            cartFooterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartFooterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartFooterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartFooterView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureCollections() {
        cartItemsCollectionView.collectionView.dataSource = self
        cartItemsCollectionView.collectionView.delegate = self
    }
}

extension CartView: CartViewProtocol {
    // TODO: implement view output methods
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension CartView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 ///cartItemsCollectionView.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
        //let product = products[indexPath.item]
        //cell.configure(with: product)
        cell.backgroundColor = .systemGray3
        return cell
    }
}
