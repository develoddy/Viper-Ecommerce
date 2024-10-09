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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Aquí configuramos los marcos (frames) de imageView y titleLabel
        let padding: CGFloat = 2.0
        
        // Definir el tamaño de la imagen (100% del alto de la celda)
        let imageHeight = contentView.bounds.height * 1
        imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.bounds.width,
            height: imageHeight
        )
        
        // Definir el tamaño del título (el 10% restante de la celda, con padding)
        let titleHeight = contentView.bounds.height * 0.1
        titleLabel.frame = CGRect(
            x: padding,
            y: imageView.frame.maxY + padding,
            width: contentView.bounds.width - 2 * padding,
            height: titleHeight
        )
        
        // Configuración del marco del precio (debajo de titleLabel)
        let priceHeight = contentView.bounds.height * 0.1
        priceLabel.frame = CGRect(
            x: padding,
            y: titleLabel.frame.maxY + padding,
            width: contentView.bounds.width - 2 * padding,
            height: priceHeight
        )
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
