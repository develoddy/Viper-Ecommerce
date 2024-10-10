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
    
    /*let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // Asegúrate de usar Auto Layout
        return scrollView
    }()*/
    let scrollView = UIScrollView()
    
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

    // MARK: - Setup View
    private func setupView() {
        addSubview(scrollView)
        
        //scrollView.frame = bounds
        
        // Configura las restricciones para que scrollView ocupe toda la vista
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
        scrollView.addSubview(mainImageView)
        scrollView.addSubview(thumbnailCollectionView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(colorsStackView)
        scrollView.addSubview(sizesStackView)
        scrollView.addSubview(actionStackView)
        scrollView.addSubview(relatedProductsCollectionView) // Agrega la colección de productos relacionados
        
        scrollView.addSubview(promotionsLabel) // Agrega el label de promociones
        scrollView.addSubview(emailTextField) // Agrega el textField para el email
        
        // Configurar el stepper para cambiar el valor de la cantidad
        quantityStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        // Definir el contenido de scrollView
        //scrollView.frame = bounds
        
        //setupConstraints()
    }
    
    

    /**private func setupConstraints() {
        let padding: CGFloat = 20
        let collectionHeight: CGFloat = 100
        let imageHeight = frame.height * 0.4
        let buttonHeight: CGFloat = 40
        
        // Configurar restricciones para la imagen principal
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            mainImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            mainImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            mainImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
        // Configurar restricciones para la colección de miniaturas
        thumbnailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailCollectionView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: padding),
            thumbnailCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            thumbnailCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            thumbnailCollectionView.heightAnchor.constraint(equalToConstant: collectionHeight)
        ])

        // Configurar restricciones para el título
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailCollectionView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
        ])

        // Configurar restricciones para el precio
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
        ])

        // Configurar restricciones para la descripción
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
        ])

        // Configurar restricciones para el StackView de colores
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            colorsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            colorsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
        ])

        // Configurar restricciones para el StackView de tallas
        sizesStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizesStackView.topAnchor.constraint(equalTo: colorsStackView.bottomAnchor, constant: 10),
            sizesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            sizesStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
        ])

        // Configurar restricciones para el actionStackView
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionStackView.topAnchor.constraint(equalTo: sizesStackView.bottomAnchor, constant: 20),
            actionStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            actionStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            actionStackView.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        // Configurar restricciones para la colección de productos relacionados
        relatedProductsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            relatedProductsCollectionView.topAnchor.constraint(equalTo: actionStackView.bottomAnchor, constant: 20),
            relatedProductsCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            relatedProductsCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            relatedProductsCollectionView.heightAnchor.constraint(equalToConstant: collectionHeight)
        ])

        // Configurar restricciones para el label de promociones
        promotionsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promotionsLabel.topAnchor.constraint(equalTo: relatedProductsCollectionView.bottomAnchor, constant: 20),
            promotionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            promotionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
        ])

        // Configurar restricciones para el textField para el email
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: promotionsLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            emailTextField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding) // Asegura que el emailTextField esté al final del scrollView
        ])
    }*/
    
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let padding: CGFloat = 20
        let collectionHeight: CGFloat = 100
        let imageHeight = frame.height * 0.4
        let labelSpacing: CGFloat = 10
        let buttonHeight: CGFloat = 40
        
        // Ajusta el contentView para que sea del mismo tamaño que el scrollView
        //self.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.contentSize.height)
        
        
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
        //addToCartButton.widthAnchor.constraint(equalTo: actionStackView.widthAnchor, multiplier: 0.6).isActive = true
        //addToCartButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Aumenta el margen izquierdo para el botón
        //addToCartButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 20).isActive = true
        

        // Layout de la colección de productos relacionados
        let relatedProductsHeight: CGFloat = 100 // Ajusta la altura según sea necesario
        relatedProductsCollectionView.frame = CGRect(
            x: padding,
            y: actionStackView.frame.maxY + padding,
            width: frame.width - padding * 2,
            height: relatedProductsHeight
        )
        
        // Layout del label de promociones
        promotionsLabel.frame = CGRect(
            x: padding,
            y: relatedProductsCollectionView.frame.maxY + labelSpacing,
            width: frame.width - padding * 2,
            height: 40 // Altura fija para el label
        )

        // Layout del textField para el email
        emailTextField.frame = CGRect(
            x: padding,
            y: promotionsLabel.frame.maxY + labelSpacing,
            width: frame.width - padding * 2,
            height: buttonHeight // Altura fija para el textField
        )
        
        // Actualiza el contentSize del scrollView
        let contentHeight = relatedProductsCollectionView.frame.maxY + padding
        scrollView.contentSize = CGSize(
            width: frame.width,
            height: contentHeight
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
