//
//  CategoryCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//

import UIKit
import SDWebImage

class CategoryCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        // Usar NSLayoutConstraint para posicionar los elementos
        NSLayoutConstraint.activate([
            // Configuración de la imagen
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5), // Ajusta la altura de la imagen

            // Configuración del título
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5.0), // Debajo de la imagen
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3) // Ajusta la altura del título
        ])
    }
    
    func configure(with category: CategorieModel) {
        titleLabel.text = category.title
        // Concatenar la URL de la imagen
        if let imageName = category.imagen {
            let imageUrlString = "\(Constants.ApiRoutes.api)/api/categories/uploads/categorie/\(imageName)"
            if let imageUrl = URL(string: imageUrlString) {
                imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) // Establece una imagen de marcador de posición si es necesario
            } else {
                imageView.image = nil // Si no hay imagen, establece la imagen a nil
            }
        } else {
            imageView.image = nil // Si no hay nombre de imagen, establece la imagen a nil
        }
        //contentView.backgroundColor = .systemGreen
    }
}
