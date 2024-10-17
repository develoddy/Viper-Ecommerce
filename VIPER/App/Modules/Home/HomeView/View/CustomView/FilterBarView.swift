//
//  FilterBarView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//

import UIKit

extension NSNotification.Name {
    static let didChangeColumnMode = NSNotification.Name("didChangeColumnMode")
}

class FilterBarView: UIView {
    
    let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ordenar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let oneColumnButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "rectangle") // Cambia "1.circle" por el nombre de la imagen que desees
        button.setImage(image, for: .normal)
        button.tintColor = .black
        // Establecer el contenido del botón
        button.imageView?.contentMode = .scaleAspectFit // Ajustar el modo de contenido de la imagen
        // Ajustar el espaciado entre la imagen y el texto
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    let twoColumnButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "rectangle.split.2x1") // Cambia "1.circle" por el nombre de la imagen que desees
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit // Ajustar el modo de contenido de la imagen
        // Ajustar el espaciado entre la imagen y el texto
        ///button.semanticContentAttribute = .forceRightToLeft // Esto es para que la imagen esté a la izquierda y el texto a la derecha
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let threeColumnButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "rectangle.split.2x2") // Cambia "1.circle" por el nombre de la imagen que desees
        button.setImage(image, for: .normal)
        button.tintColor = .black
        // Establecer el contenido del botón
        button.imageView?.contentMode = .scaleAspectFit // Ajustar el modo de contenido de la imagen
        //button.setPreferredSymbolConfiguration(.init(pointSize: 24, weight: .light), forImageIn: .normal) // Ajustar el tamaño de la imagen
        ///button.heightAnchor.constraint(equalToConstant: 50).isActive = true // Cambiar 50 a la altura deseada
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Variable para controlar el modo seleccionado
    //var selectedColumnMode: Int = 2 // Inicialmente 2 columnas
    
    // Variable para controlar el modo seleccionado
   var selectedColumnMode: Int = 2 { // Inicialmente 2 columnas
       didSet {
           // Notificar a los observadores sobre el cambio de modo
           NotificationCenter.default.post(name: .didChangeColumnMode, object: nil)
       }
   }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = UIColor.systemBackground
        addSubview(sortButton)
        addSubview(oneColumnButton)
        addSubview(twoColumnButton)
        addSubview(threeColumnButton)
        
        // Configurar las restricciones de los botones
        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 40),
            sortButton.widthAnchor.constraint(equalToConstant: 100),
            sortButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            oneColumnButton.heightAnchor.constraint(equalToConstant: 40),
            oneColumnButton.widthAnchor.constraint(equalToConstant: 40),
            oneColumnButton.trailingAnchor.constraint(equalTo: twoColumnButton.leadingAnchor, constant: -8),
            oneColumnButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            twoColumnButton.heightAnchor.constraint(equalToConstant: 40),
            twoColumnButton.widthAnchor.constraint(equalToConstant: 40),
            twoColumnButton.trailingAnchor.constraint(equalTo: threeColumnButton.leadingAnchor, constant: -8),
            twoColumnButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            threeColumnButton.heightAnchor.constraint(equalToConstant: 40),
            threeColumnButton.widthAnchor.constraint(equalToConstant: 40),
            threeColumnButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            threeColumnButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Acciones para los botones
        oneColumnButton.addTarget(self, action: #selector(selectOneColumn), for: .touchUpInside)
        twoColumnButton.addTarget(self, action: #selector(selectTwoColumns), for: .touchUpInside)
        threeColumnButton.addTarget(self, action: #selector(selectThreeColumns), for: .touchUpInside)
    }
    
    @objc private func selectOneColumn() {
        selectedColumnMode = 1
        NotificationCenter.default.post(name: .didChangeColumnMode, object: nil)
    }
    
    @objc private func selectTwoColumns() {
        selectedColumnMode = 2
        NotificationCenter.default.post(name: .didChangeColumnMode, object: nil)
    }
    
    @objc private func selectThreeColumns() {
        selectedColumnMode = 3
        NotificationCenter.default.post(name: .didChangeColumnMode, object: nil)
    }
}
