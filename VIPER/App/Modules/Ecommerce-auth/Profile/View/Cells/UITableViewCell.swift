//
//  UITableViewCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//

import UIKit

class ProfileOptionCell: UITableViewCell {

    // MARK: Properties
    static let identifier = "ProfileOptionCell"
    
    // Elementos visuales
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configurar la celda
    private func setupView() {
        addSubview(optionLabel)
        addSubview(arrowImageView)
        
        // Constraints
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // Método para configurar el texto de la celda
    func configure(with title: String) {
        optionLabel.text = title
    }
}

