//
//  ListAddressView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

class ListAddressView: UIViewController {

    // MARK: - Properties
    var presenter: ListAddressPresenterProtocol?
    
    private let listAddressItemView = ListAddressItemView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
        configureCollection()
        
        // Configurar acción para el botón
        listAddressItemView.addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listAddressItemView.frame = view.bounds
    }
    
    // MARK:
    func setupView() {
        view.backgroundColor = .systemBackground
        title = "Mis direcciones"
        
        // Añadir wishlistItemView a la vista principal
        view.addSubview(listAddressItemView)
    }
    
    private func configureCollection() {
        listAddressItemView.collectionView.dataSource = self
        listAddressItemView.collectionView.delegate = self
        
        // Configurar las constraints
        NSLayoutConstraint.activate([
            listAddressItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),/// Espacio de 20 puntos desde la barra superior
            listAddressItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listAddressItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listAddressItemView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Button Tap
    @objc private func addAddressButtonTapped() {
        print("Botón Añadir dirección presionado")
        // Aquí puedes manejar la lógica para añadir una nueva dirección, por ejemplo:
        // presenter?.addNewAddress()
    }
}

// MARK: - ListAddressViewProtocol
extension ListAddressView: ListAddressViewProtocol {
    func updateUIList() {
        DispatchQueue.main.async {
            self.listAddressItemView.collectionView.reloadData()
        }
    }
    
    func onError(_ error: Error) {
        print("Error in View fetching wishlist: \(error.localizedDescription)")
    }
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension ListAddressView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListAddressItemCell.identifier, for: indexPath) as? ListAddressItemCell else {
            return UICollectionViewCell()
        }
        
        if let item = presenter?.getItem(at: indexPath.item) {
            /// Configurar la celda con datos de producto
            let address = item
            /// Asegúrate de que tu celda tenga un método configure para establecer estos valores
            cell.configure(with: address)
        }
        cell.backgroundColor = .systemBackground // Cambiar color de celda
        
        /// Configurar la acción del botón de la celda
        ///cell.addButtonAction = { [weak self] in
        ///    self?.presentAddToCartActionSheet()
        /// }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the item
        collectionView.deselectItem(at: indexPath, animated: true)

        // Comprobar si se trata de la sección de productos de favories
        if indexPath.section == 0 {
            // Notificar al Presenter que se ha seleccionado un producto
            ///presenter?.didSelectProduct(at: indexPath.item)
        }
    }
}

extension ListAddressView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // Espacio en los lados
        let cellWidth = collectionView.bounds.width - (padding * 2) // Ancho de la celda
        return CGSize(width: cellWidth, height: 250) // Altura fija
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16) // Márgenes
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaciado entre filas
    }
}

