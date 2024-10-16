//
//  WishlistItemCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//

import UIKit
import SDWebImage

class WishlistItemCell: UICollectionViewCell {
    
    static let identifier = "WishlistItemCell"
    
    var addButtonAction: (() -> Void)? // Closure para manejar la acción del botón

    // Elementos visuales dentro de la celda
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        ///label.text = "titulo de producto"
        //label.backgroundColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        ///label.text = "$99.99"
        //label.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Añadir", for: .normal)
        
        // Estilo del botón
        button.backgroundColor = .white  // Fondo blanco
        button.setTitleColor(.black, for: .normal)  // Texto negro
        button.layer.borderColor = UIColor.black.cgColor  // Borde negro
        button.layer.borderWidth = 1  // Grosor del borde
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Inicializador
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside) // Añadir acción al botón
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuración de la celda
    private func setupCell() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favoriteIcon)
        contentView.addSubview(addButton)
        
        // Definir las constraints
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 230),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            favoriteIcon.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            favoriteIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),  // Margen derecho de 16
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20),
            
            addButton.topAnchor.constraint(equalTo: favoriteIcon.bottomAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10), // Margen izquierdo de 10
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10), // Margen derecho de 10
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func didTapAddButton() {
        addButtonAction?() // Llamar a la acción del botón
    }
    
    // Método para configurar los datos de la celda
    func configure(with product: ProductModelResponse) {
        /// productImageView.image = product.image
        titleLabel.text = product.title
        print("product.priceUsd: \(product.priceUsd)")
        priceLabel.text = "$\(product.priceUsd)"
        
        if let imageUrlString = product.imagen, let imageUrl = URL(string: imageUrlString) {
            productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) // Establece una imagen de marcador de posición si es necesario
        } else {
            productImageView.image = nil
        }
    }
}
