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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 5.0
        
        // Establecer el marco para la imagen
        let imageHeight: CGFloat = contentView.bounds.height * 0.5 // Ajusta la altura de la imagen (50% de la celda)
        imageView.frame = CGRect(
            x: (contentView.bounds.width - contentView.bounds.width * 0.8) / 2, // Centra la imagen horizontalmente
            y: 0,
            width: contentView.bounds.width * 0.8, // Establece el ancho de la imagen (80% de la celda)
            height: imageHeight // Usa la altura ajustada
        )
        
        // Establecer el marco para el título
        titleLabel.frame = CGRect(
            x: padding,
            y: imageView.frame.maxY + padding, // Debajo de la imagen con un margen
            width: contentView.bounds.width - 2 * padding,
            height: contentView.bounds.height * 0.3 - padding // Ajusta la altura del título (30% de la celda)
        )
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
        contentView.backgroundColor = .systemGreen
    }
}
