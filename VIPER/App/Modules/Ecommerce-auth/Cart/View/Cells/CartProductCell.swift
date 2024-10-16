//
//  CartProductCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//

import UIKit

import UIKit

class CartProductCell: UICollectionViewCell {
    
    static let identifier = "CartProductCell"

    // MARK: - Subviews
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupCell() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(colorLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            
            quantityLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            
            sizeLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            sizeLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 4),
            
            colorLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            colorLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 4),
            colorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure Cell
    //func configure(with product: ProductModel) {
    func configure(with product: ProductAPIModel) {
        /*productImageView.image = UIImage(named: product.imageName)
        productNameLabel.text = product.name
        priceLabel.text = "€\(product.price)"
        quantityLabel.text = "Cantidad: \(product.quantity)"
        sizeLabel.text = "Talla: \(product.size)"
        colorLabel.text = "Color: \(product.color)"*/
        
        if let imageUrlString = product.imagen, let imageUrl = URL(string: imageUrlString) {
            productImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) // Establece una imagen de marcador de posición si es necesario
        } else {
            productImageView.image = nil
        }
    }
}
