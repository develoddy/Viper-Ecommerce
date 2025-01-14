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

    // MARK: - Properties
    var presenter: WishlistPresenterProtocol?
    
    // Crear una instancia de WishlistItemView
    private let wishlistItemView = WishlistItemView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupView()
        presenter?.viewDidLoad()
        configureCollection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /// Establecer el frame de la vista personalizada para que ocupe toda la vista principal
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
        
        // Configurar las constraints
        NSLayoutConstraint.activate([
            wishlistItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),/// Espacio de 20 puntos desde la barra superior
            wishlistItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wishlistItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wishlistItemView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - WishlistViewProtocol
extension WishlistView: WishlistViewProtocol {

    func updateUIList() {
        DispatchQueue.main.async {
            //self.homeUI.tableView.reloadData()
            print("Actualizando la UI...")
            self.wishlistItemView.collectionView.reloadData() // Asegúrate de que hay un método en HomeItemView para recargar datos
        }
    }
    
    func onError(_ error: Error) {
        print("Error in View fetching wishlist: \(error.localizedDescription)")
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension WishlistView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0 // Devuelve el número de productos de la wishlist
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistItemCell.identifier, for: indexPath) as? WishlistItemCell else {
            return UICollectionViewCell()
        }
        
        if let item = presenter?.getItem(at: indexPath.item) {
            /// Configurar la celda con datos de producto
            let product = item.product
            /// Asegúrate de que tu celda tenga un método configure para establecer estos valores
            cell.configure(with: product)
        }
        cell.backgroundColor = .systemBackground // Cambiar color de celda
        
        /// Configurar la acción del botón de la celda
        cell.addButtonAction = { [weak self] in
            self?.presentAddToCartActionSheet()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the item
        collectionView.deselectItem(at: indexPath, animated: true)

        // Comprobar si se trata de la sección de productos de favories
        if indexPath.section == 0 {
            // Notificar al Presenter que se ha seleccionado un producto
            presenter?.didSelectProduct(at: indexPath.item)
        }
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

// MARK: - UICollectionViewDelegateFlowLayout
/// Opción 1: Cambiar el tamaño en el flujo de diseño Modifica el método sizeForItemAt en la extensión de UICollectionViewDelegateFlowLayout de la siguiente manera:
extension WishlistView: UICollectionViewDelegateFlowLayout {
    // Método para proporcionar la vista del header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WishlistHeaderView.identifier, for: indexPath) as? WishlistHeaderView else {
                return UICollectionReusableView()
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    // Se define el tamaño del header. (es otra opcion)
    ///func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    ///    return CGSize(width: collectionView.frame.width, height: 80) // Altura de 100 para el header
    ///}
}
