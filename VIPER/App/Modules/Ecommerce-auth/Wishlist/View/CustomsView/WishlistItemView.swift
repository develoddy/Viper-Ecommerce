//
//  WishlistItemView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//

import UIKit

class WishlistItemView: UIView {

    // Crear el UICollectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 2, height: 350) // Aumentar la altura a 300
        
        // Definir el tamaño del header
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Inicializador
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuración del layout de la vista
    private func setupView() {
        addSubview(collectionView)
        
        // Constraints para que el UICollectionView ocupe toda la vista
        ///// Constraints para que el UICollectionView tenga más espacio en la parte superior
        NSLayoutConstraint.activate([
            ///collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Configuración del UICollectionView
    private func configureCollectionView() {
        // Registrar la celda personalizada
        collectionView.register(WishlistItemCell.self, forCellWithReuseIdentifier: WishlistItemCell.identifier)
        
        // Registrar el header
        collectionView.register(WishlistHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WishlistHeaderView.identifier)
    }
}


