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
    
    // ScrollView para toda la vista
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Contenedor que estará dentro del ScrollView
    let contentView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit//.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
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
        return stackView
    }()
    
    // StackView para tallas
    private lazy var sizesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: sizeButtons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    // Botón de incrementar la cantidad de productos
    let quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 99
        stepper.value = 1
        stepper.tintColor = .systemBlue
        return stepper
    }()
    
    // Etiqueta para mostrar la cantidad seleccionada
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    // Botón de "Añadir al carrito"
    let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Añadir al carrito", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
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
        return stackView
    }()
    
    // Nuevo UILabel para promociones
    let titleRelatedProductsLabel: UILabel = {
        let label = UILabel()
        label.text = "PRODUCTOS RELACIONADOS"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // 1. Agrega la propiedad para el UICollectionView de productos relacionados
    var relatedProductsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RelatedProductCell.self, forCellWithReuseIdentifier: RelatedProductCell.identifier)
        return collectionView
    }()
    
    // Nuevo UILabel para promociones
    let promotionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Recibe promociones exclusivas, ventas privadas y novedades"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // Nuevo UITextField para el correo electrónico
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        // Agregar ScrollView y ContentView
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Agregar todos los subviews al scrollView
        let views: [UIView] = [
            mainImageView,
            thumbnailCollectionView,
            titleLabel,
            priceLabel,
            descriptionLabel,
            colorsStackView,
            sizesStackView,
            actionStackView,
            titleRelatedProductsLabel,
            relatedProductsCollectionView,
            promotionsLabel,
            emailTextField
        ]
        
        for view in views {
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Constraints del ScrollView y el ContentView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // El ancho del contentView es igual al del scrollView
        ])
        
        // Configura restricciones para todos los elementos aquí
        NSLayoutConstraint.activate([
            // Constraints para mainImageView
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 400), // Altura fija
            //mainImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            // Constraints para thumbnailCollectionView
            thumbnailCollectionView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10),
            thumbnailCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            thumbnailCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            thumbnailCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            // Constraints para titleLabel
            titleLabel.topAnchor.constraint(equalTo: thumbnailCollectionView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para priceLabel
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para colorsStackView
            colorsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            colorsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            colorsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para sizesStackView
            sizesStackView.topAnchor.constraint(equalTo: colorsStackView.bottomAnchor, constant: 10),
            sizesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sizesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para actionStackView
            actionStackView.topAnchor.constraint(equalTo: sizesStackView.bottomAnchor, constant: 20),
            actionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para titleRelatedProductsLabel
            titleRelatedProductsLabel.topAnchor.constraint(equalTo: actionStackView.bottomAnchor, constant: 20),
            titleRelatedProductsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleRelatedProductsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para relatedProductsCollectionView
            relatedProductsCollectionView.topAnchor.constraint(equalTo: titleRelatedProductsLabel.bottomAnchor, constant: 20),
            relatedProductsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            relatedProductsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            relatedProductsCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            // Constraints para promotionsLabel
            promotionsLabel.topAnchor.constraint(equalTo: relatedProductsCollectionView.bottomAnchor, constant: 20),
            promotionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            promotionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Constraints para emailTextField
            emailTextField.topAnchor.constraint(equalTo: promotionsLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // Asegúrate de que el textField esté alineado al fondo del scrollView
        ])
    }

    // MARK: - Actions
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(sender.value))"
    }
}
