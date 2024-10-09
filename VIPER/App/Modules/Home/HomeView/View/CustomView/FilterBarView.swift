//
//  FilterBarView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//

import UIKit

class FilterBarView: UIView {
    
    let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ordenar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
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
        addSubview(filterButton)
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           
           // Ajustar el tamaño y posición del botón "Ordenar"
           let buttonHeight: CGFloat = 40
           let buttonWidth: CGFloat = 100
           let padding: CGFloat = 16
           
           sortButton.frame = CGRect(
               x: padding,
               y: (frame.height - buttonHeight) / 2, // Centrado verticalmente
               width: buttonWidth,
               height: buttonHeight
           )
           
           // Ajustar el tamaño y posición del botón "Filtrar"
           filterButton.frame = CGRect(
               x: frame.width - buttonWidth - padding,
               y: (frame.height - buttonHeight) / 2, // Centrado verticalmente
               width: buttonWidth,
               height: buttonHeight
           )
       }
}

