//
//  ListAddressItemCell.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//

import UIKit

class ListAddressItemCell: UICollectionViewCell {
    
    static let identifier = "ListAddressItemCell"
    
    var editButtonAction: (() -> Void)?
    var deleteButtonAction: (() -> Void)?
    
    // Elementos visuales
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shippingLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = UIColor.systemGray6
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8) // Reduce el padding superior e inferior
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Editar"
        configuration.baseBackgroundColor = .systemGray6
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16) // Padding a los 4 lados
        configuration.cornerStyle = .capsule
     
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Eliminar"
        configuration.baseBackgroundColor = .systemGray6
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16) // Padding a los 4 lados
        configuration.cornerStyle = .capsule
       
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // Configuración del borde
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 0
        contentView.clipsToBounds = true
        
        // Añadir subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(shippingLabel)
        contentView.addSubview(dividerLine)
        contentView.addSubview(editButton)
        contentView.addSubview(deleteButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 20), // Limitar la altura del título
            
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addressLabel.bottomAnchor.constraint(lessThanOrEqualTo: shippingLabel.topAnchor, constant: -8),
            
            shippingLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            shippingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shippingLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            shippingLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            dividerLine.topAnchor.constraint(equalTo: shippingLabel.bottomAnchor, constant: 16),
            dividerLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            
            editButton.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 16),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            deleteButton.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapEditButton() {
        editButtonAction?()
    }
    
    @objc private func didTapDeleteButton() {
        deleteButtonAction?()
    }
    
    func configure(with address: SaleAddressModel) {
        titleLabel.text = address.name
        addressLabel.text = "\(address.address )\n\n\(address.zipcode ?? "0") \(address.ciudad), \(address.poblacion)\n\nTel. \(address.phone)"
        shippingLabel.text = "Dirección de envío habitual"
    }
}
