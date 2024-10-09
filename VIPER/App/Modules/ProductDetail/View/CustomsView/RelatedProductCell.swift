//
//  RelatedProductCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 9/10/24.
//

import UIKit


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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemTeal
        imageView.frame = contentView.bounds
    }
    
    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
