//
//  ThumbnailCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 10/10/24.
//

import UIKit
import SDWebImage

class ThumbnailCell: UICollectionViewCell {
    
    static let identifier = "ThumbnailCell"
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnailImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemCyan
        thumbnailImageView.frame = contentView.bounds
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with galeria: GaleriaModel) {
        //func configure(with imageName: String) {
        //thumbnailImageView.image = UIImage(named: galeias.imagen ?? "")
        
        //print("---> ThumbnailCell: \(galerias)")
        
        /*if let imageUrlString = product.imagen, let imageUrl = URL(string: imageUrlString) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) // Establece una imagen de marcador de posición si es necesario
        } else {
            imageView.image = nil
        }*/
        
        // Suponiendo que solo quieres mostrar la primera imagen
        // Cargar la imagen usando SDWebImage
        guard let imageUrlString = galeria.imagen,
              let imageUrl = URL(string: imageUrlString) else {
            thumbnailImageView.image = nil // O puedes establecer una imagen de marcador de posición
            return
        }
        
        thumbnailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        
        
        // Asignar color de fondo a la celda
        contentView.backgroundColor = .lightGray
    }
}
