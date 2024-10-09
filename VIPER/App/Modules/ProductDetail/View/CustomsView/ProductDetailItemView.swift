//
//  ProductDetailItemView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 9/10/24.
//

import Foundation

import UIKit

  
class ProductDetailItemView: UIView {

    // MARK: - UI Components
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .brown
        return imageView
    }()

    var thumbnailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        return collectionView
    }()
    
    // Mock data for now
    ///private let thumbnails = ["thumb1", "thumb2", "thumb3", "thumb4", "thumb5"]
    
    // Título del producto
   let titleLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 24)
       label.textAlignment = .left
       label.numberOfLines = 0
       label.text = "Nombre del producto"
       label.backgroundColor = .systemBlue
       label.textColor = .white
       return label
   }()
   
   // Precio del producto
   let priceLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 20)
       label.textAlignment = .left
       label.textColor = .systemGreen
       label.text = "$99.99"
       label.backgroundColor = .systemGreen
       label.textColor = .white
       return label
   }()
   
   // Descripción del producto
   let descriptionLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 16)
       label.textAlignment = .left
       label.numberOfLines = 0
       label.text = "Descripción del producto"
       label.backgroundColor = .systemPurple
       label.textColor = .white
       return label
   }()
    
    // Botones de colores
    let colorButtons: [UIButton] = {
        let colors: [UIColor] = [.red, .green, .blue, .yellow]
        return colors.map { color in
            let button = UIButton(type: .system)
            button.backgroundColor = color
            button.layer.cornerRadius = 20 // Botón redondo
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    }()
    
    // Botones de tallas
    let sizeButtons: [UIButton] = {
        let sizes = ["S", "M", "L", "XL"]
        return sizes.map { size in
            let button = UIButton(type: .system)
            button.setTitle(size, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemGray5
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
    }()
    
    // StackView para colores
    private lazy var colorsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // StackView para tallas
    private lazy var sizesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: sizeButtons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // Botón de incrementar la cantidad de productos
    let quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 99
        stepper.value = 1
        stepper.tintColor = .systemBlue
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    // Etiqueta para mostrar la cantidad seleccionada
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "1"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Botón de "Añadir al carrito"
    let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Añadir al carrito", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Contenedor horizontal para el Stepper de cantidad y el botón "Añadir al carrito"
    private lazy var actionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.addArrangedSubview(quantityStepper)
        stackView.addArrangedSubview(quantityLabel)
        stackView.addArrangedSubview(addToCartButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // 1. Agrega la propiedad para el UICollectionView de productos relacionados
    var relatedProductsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RelatedProductCell.self, forCellWithReuseIdentifier: RelatedProductCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupView() {
        addSubview(mainImageView)
        addSubview(thumbnailCollectionView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(descriptionLabel)
        addSubview(colorsStackView)
        addSubview(sizesStackView)
        addSubview(actionStackView)
        addSubview(relatedProductsCollectionView) // Agrega la colección de productos relacionados
        
        // Configurar el stepper para cambiar el valor de la cantidad
        quantityStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ///let padding: CGFloat = 20
        ///let collectionHeight: CGFloat = 100
        ///let imageHeight = frame.height - collectionHeight - padding * 2
        
        ///let padding: CGFloat = 20
        ///let collectionHeight: CGFloat = 100
        ///let imageHeight = frame.height * 0.4
        ///let labelSpacing: CGFloat = 10
        
        let padding: CGFloat = 20
        let collectionHeight: CGFloat = 100
        let imageHeight = frame.height * 0.4
        let labelSpacing: CGFloat = 10
        let buttonHeight: CGFloat = 40
        
        
        // Layout de la imagen principal
        mainImageView.frame = CGRect(
            x: padding,
            y: padding,
            width: frame.width - padding * 2,
            height: imageHeight
        )
        
        // Layout de la colección de miniaturas
        thumbnailCollectionView.frame = CGRect(
            x: padding,
            y: mainImageView.frame.maxY + padding,
            width: frame.width - padding * 2,
            height: collectionHeight
        )
        
        // Layout del título
        let titleSize = titleLabel.sizeThatFits(CGSize(width: frame.width - padding * 2, height: CGFloat.greatestFiniteMagnitude))
        titleLabel.frame = CGRect(
            x: padding,
            y: thumbnailCollectionView.frame.maxY + padding,
            width: frame.width - padding * 2,
            height: titleSize.height
        )
        
        // Layout del precio
        let priceSize = priceLabel.sizeThatFits(CGSize(width: frame.width - padding * 2, height: CGFloat.greatestFiniteMagnitude))
        priceLabel.frame = CGRect(
            x: padding,
            y: titleLabel.frame.maxY + labelSpacing,
            width: frame.width - padding * 2,
            height: priceSize.height
        )
        
        // Layout de la descripción
        let descriptionSize = descriptionLabel.sizeThatFits(CGSize(width: frame.width - padding * 2, height: CGFloat.greatestFiniteMagnitude))
        descriptionLabel.frame = CGRect(
            x: padding,
            y: priceLabel.frame.maxY + labelSpacing,
            width: frame.width - padding * 2,
            height: descriptionSize.height
        )
        
        // Layout del StackView de colores
        colorsStackView.frame = CGRect(
            x: padding,
            y: descriptionLabel.frame.maxY + labelSpacing,
            width: frame.width - padding * 2,
            height: buttonHeight
        )
        
        // Layout del StackView de tallas
        sizesStackView.frame = CGRect(
            x: padding,
            y: colorsStackView.frame.maxY + labelSpacing,
            width: frame.width - padding * 2,
            height: buttonHeight
        )
        
        
        // Layout del contenedor del Stepper y botón "Añadir al carrito"
        actionStackView.frame = CGRect(
            x: padding,
            y: sizesStackView.frame.maxY + padding,
            width: frame.width - padding * 2,
            height: buttonHeight
        )
        
        // Agregar un margen izquierdo al botón "Añadir al carrito"
        addToCartButton.widthAnchor.constraint(equalTo: actionStackView.widthAnchor, multiplier: 0.6).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Aumenta el margen izquierdo para el botón
        addToCartButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 20).isActive = true
        
        
        // Layout del contenedor del Stepper y botón "Añadir al carrito"
        actionStackView.frame = CGRect(
            x: padding,
            y: sizesStackView.frame.maxY + padding,
            width: frame.width - padding * 2,
            height: buttonHeight
        )

        // Layout de la colección de productos relacionados
        let relatedProductsHeight: CGFloat = 100 // Ajusta la altura según sea necesario
        relatedProductsCollectionView.frame = CGRect(
            x: padding,
            y: actionStackView.frame.maxY + padding,
            width: frame.width - padding * 2,
            height: relatedProductsHeight
        )
    }
    
    // MARK: - Actions
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
    }
}

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
    }
    
    func configure(with imageName: String) {
        thumbnailImageView.image = UIImage(named: imageName)
    }
}
