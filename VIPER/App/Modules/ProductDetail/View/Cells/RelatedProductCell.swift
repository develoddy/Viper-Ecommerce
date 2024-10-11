//
//  RelatedProductCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 9/10/24.
//

import UIKit
import SDWebImage

// 2. Crea una clase para la celda de productos relacionados
class RelatedProductCell: UICollectionViewCell {
    static let identifier = "RelatedProductCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .systemGray5
        //setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemTeal
        //imageView.frame = contentView.bounds
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    //func configure(with imageName: String) {
    func configure(with relatedProduct: ProductModel) {
        //imageView.image = UIImage(named: imageName)
        
        // Cargar la imagen usando SDWebImage
        guard let imageUrlString = relatedProduct.imagen,
              let imageUrl = URL(string: imageUrlString) else {
            imageView.image = nil // O puedes establecer una imagen de marcador de posición
            return
        }
        
        imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
