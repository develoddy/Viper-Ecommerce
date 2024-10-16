//
//  CartItemView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//

import UIKit

class CartFooterView: UIView {

    // MARK: - Subviews
    private let subtotalLabel: UILabel = {
        let label = UILabel()
        ///label.text = "Subtotal: €150.99"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shippingLabel: UILabel = {
        let label = UILabel()
        label.text = "Envío gratuito"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        ///label.text = "Total: €200.99"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Comenzar pedido", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Footer
    private func setupFooter() {
        // Crear un contenedor para los labels y el botón
        let footerView = UIView()
        footerView.backgroundColor = .white
        footerView.layer.shadowColor = UIColor.black.cgColor
        footerView.layer.shadowOpacity = 0.1
        footerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Añadir el footer a la vista principal
        addSubview(footerView)
        
        // Añadir subviews al footer
        footerView.addSubview(subtotalLabel)
        footerView.addSubview(shippingLabel)
        footerView.addSubview(totalLabel)
        footerView.addSubview(checkoutButton)
        
        // Configurar restricciones para el footerView
        NSLayoutConstraint.activate([
            // Fijar el footerView al fondo de la pantalla
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Altura del footerView
            footerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Configurar restricciones para los elementos dentro del footer
        NSLayoutConstraint.activate([
            // Subtotal label
            subtotalLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            subtotalLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 16),
            
            // Shipping label
            shippingLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            shippingLabel.topAnchor.constraint(equalTo: subtotalLabel.bottomAnchor, constant: 8),
            
            // Total label
            totalLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            totalLabel.centerYAnchor.constraint(equalTo: subtotalLabel.centerYAnchor),
            
            // Botón de "Comenzar pedido"
            checkoutButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            checkoutButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -16),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(with cart: CartsAPIResponse) {
        /*if let subtotal = cart.subtotal {
            subtotalLabel.text = "Cantidad: \(String(describing: subtotal))"
        }
        
        if let total = cart.total {
            subtotalLabel.text = "Cantidad: \(String(describing: total))"
        }*/
        
        // Suponiendo que cart contiene un array de productos, y cada producto tiene un campo `total` como String opcional
        let totalAmount = cart.carts.reduce(0.0) { (sum, item) -> Double in
            // Convertir el String a Double y usar 0.0 si la conversión falla
            if let totalString = item.total, let totalValue = Double(totalString) {
                return sum + totalValue
            } else {
                return sum
            }
        }
        
        // Redondear el total a dos decimales
        let formattedTotal = String(format: "%.2f", totalAmount)
        
        // Actualizar el subtotal y total en las etiquetas
        subtotalLabel.text = "Subtotal: €\(formattedTotal)"
        totalLabel.text = "Total: €\(formattedTotal)"
    }
}
