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
    
    private let cartItemView = CartItemView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        title = "Carrito de compra"
        view.backgroundColor = .systemBackground
        
        // Añadir subviews
        view.addSubview(cartItemView)
        view.addSubview(cartFooterView)
        
        // Configurar restricciones
        setupConstraints()
        configureCollections()
    }
    
    private func setupConstraints() {
        cartItemView.translatesAutoresizingMaskIntoConstraints = false
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // CartItemsCollectionView constraints
            cartItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartItemView.bottomAnchor.constraint(equalTo: cartFooterView.topAnchor),
            
            // CartFooterView constraints
            cartFooterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartFooterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartFooterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartFooterView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureCollections() {
        cartItemView.collectionView.dataSource = self
        cartItemView.collectionView.delegate = self
    }
}

extension CartView: CartViewProtocol {
    
    // TODO: implement view output methods
    func updateUIList() {
        DispatchQueue.main.async {
            //self.homeUI.tableView.reloadData()
            print("Actualizando la UI Carts...")
            self.cartItemView.collectionView.reloadData() // Asegúrate de que hay un método en HomeItemView para recargar datos
        }
    }
    
    func updateFooter(with carts: CartsAPIResponse) {
        DispatchQueue.main.async {
            self.cartFooterView.configure(with: carts)
        }
    }
    
  
    func onError(_ error: Error) {
        print("Error in View fetching Carts: \(error.localizedDescription)")
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension CartView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
        if let item = presenter?.getItem(at: indexPath.item) {
            ///let product = item.product
            //cell.configure(with: product)
            
            cell.configure(with: item)
        }
        cell.backgroundColor = .systemBackground
        return cell
    }
}
