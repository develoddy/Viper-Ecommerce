//
//  ListAddressItemView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//

import UIKit

class ListAddressItemView: UIView {

    // Crear el UICollectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 5
        //layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 2, height: 350) // Aumentar la altura a 300
        
        // Definir el tamaño del header
        // layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Crear el botón "Añadir dirección"
    let addAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Añadir dirección", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(addAddressButton) // Agregar el botón a la vista
        
        NSLayoutConstraint.activate([
            
            // Constraints para collectionView
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Constraints para el botón
            addAddressButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addAddressButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addAddressButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            addAddressButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Configuración del UICollectionView
    private func configureCollectionView() {
        // Registrar la celda personalizada
        collectionView.register(ListAddressItemCell.self, forCellWithReuseIdentifier: ListAddressItemCell.identifier)
    }
}
