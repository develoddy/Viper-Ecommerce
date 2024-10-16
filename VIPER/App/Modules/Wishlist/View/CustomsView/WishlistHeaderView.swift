//
//  WishlistHeaderView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 16/10/24.
//

import UIKit

class WishlistHeaderView: UICollectionReusableView {
    static let identifier = "WishlistHeaderView"
    
    // Label para la descripción
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "EddyLujan, estos son los artículos que más te gustan"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuración del layout de la vista
    private func setupView() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            ///descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
