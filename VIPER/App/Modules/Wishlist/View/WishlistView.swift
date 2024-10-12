//
//  WishlistView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//  
//

import Foundation
import UIKit

class WishlistView: UIViewController {

    // MARK: Properties
    var presenter: WishlistPresenterProtocol?
    
    // Crear una instancia de WishlistItemView
    private let wishlistItemView = WishlistItemView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupView()
        presenter?.viewDidLoad()
        configureCollection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Establecer el frame de la vista personalizada para que ocupe toda la vista principal
        wishlistItemView.frame = view.bounds
    }
        
    private func setupView() {
        title = "Mis favoritos"
        view.backgroundColor = .systemBackground
        
        // Añadir wishlistItemView a la vista principal
        view.addSubview(wishlistItemView)
    }
    
    private func configureCollection() {
        wishlistItemView.collectionView.dataSource = self
        wishlistItemView.collectionView.delegate = self
    }
}

// MARK: - WishlistViewProtocol
extension WishlistView: WishlistViewProtocol {
    // TODO: implement view output methods
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension WishlistView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15 // Número de productos (esto vendrá del presenter)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistItemCell.identifier, for: indexPath) as? WishlistItemCell else {
            return UICollectionViewCell()
        }
        
        // Configurar la celda con datos de producto
        //let dummyProduct = Product(image: UIImage(named: "placeholder")!, title: "Producto \(indexPath.row)", price: 99.99)
        //cell.configure(with: dummyProduct)
        cell.backgroundColor = .systemGray6
        
        // Configurar la acción del botón de la celda
        cell.addButtonAction = { [weak self] in
            self?.presentAddToCartActionSheet()
        }
        
        return cell
    }
    
    // Método para mostrar el UIAlertController en estilo .actionSheet
    func presentAddToCartActionSheet() {
        let actionSheet = UIAlertController(title: "Añadir al carrito", message: "¿Quieres añadir este producto al carrito?", preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: "Añadir", style: .default) { _ in
            print("Producto añadido al carrito")
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        actionSheet.addAction(addAction)
        actionSheet.addAction(cancelAction)
        
        // Presentar la acción sheet
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view // Soporte para iPad
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
}

