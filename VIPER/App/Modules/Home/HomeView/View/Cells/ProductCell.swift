//
//  ProductCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 6/10/24.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        // Usar NSLayoutConstraint para posicionar los elementos
        NSLayoutConstraint.activate([
            // Configuración de la imagen
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9), // Ajustar según sea necesario

            // Configuración del título
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2.0),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1), // Ajustar según sea necesario

            // Configuración del precio
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.0),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2.0),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2.0),
            priceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1) // Ajustar según sea necesario
        ])
    }
    
    func configure(with product: ProductModel) {
        titleLabel.text = product.title ?? "Sin título"
        
        if let price = product.priceUsd {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = "Sin precio"
        }
        
        if let imageUrlString = product.imagen, let imageUrl = URL(string: imageUrlString) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) // Establece una imagen de marcador de posición si es necesario
        } else {
            imageView.image = nil
        }
        
        // Asignar color de fondo a la celda
        contentView.backgroundColor = .lightGray
    }
}
