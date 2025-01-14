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
    
    private let emptyCartView = EmptyCartView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
        
        emptyCartView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setupView() {
        title = "Carrito de compra"
        view.backgroundColor = .systemBackground
        
        // Añadir subviews
        view.addSubview(cartItemView)
        view.addSubview(cartFooterView)
        view.addSubview(emptyCartView)
        
        // Configurar restricciones
        setupConstraints()
        configureCollections()
        
        // Inicialmente ocultamos la vista vacía
        emptyCartView.isHidden = true
    }
    
    private func setupConstraints() {
        cartItemView.translatesAutoresizingMaskIntoConstraints = false
        cartFooterView.translatesAutoresizingMaskIntoConstraints = false
        emptyCartView.translatesAutoresizingMaskIntoConstraints = false

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
            cartFooterView.heightAnchor.constraint(equalToConstant: 150),
            
            // EmptyCartView constraints
            emptyCartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyCartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyCartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyCartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureCollections() {
        cartItemView.collectionView.dataSource = self
        cartItemView.collectionView.delegate = self
    }
    
    // Mostrar la vista de carrito vacío si no hay productos
    private func showEmptyCartView(_ show: Bool) {
       emptyCartView.isHidden = !show
       cartItemView.isHidden = show
       cartFooterView.isHidden = show
    }
    
    // MARK: - Actions
    @objc private func didTapLoginButton() {
        presenter?.didTapLoginButton()
    }
}

// MARK: - CartViewProtocol
extension CartView: CartViewProtocol {
    func updateUIList() {
        DispatchQueue.main.async {
            let isEmpty = self.presenter?.numberOfItems() == 0
            self.showEmptyCartView(isEmpty)
            if !isEmpty {
                self.cartItemView.collectionView.reloadData()
            }
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.cartItemView.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.cartItemView.collectionView.alpha = 0.0
            })
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.cartItemView.activityIndicator.stopAnimating()
            self.cartItemView.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.cartItemView.collectionView.alpha = 1.0
            })
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
            cell.configure(with: item)
        }
        cell.backgroundColor = .systemBackground
        return cell
    }
}
