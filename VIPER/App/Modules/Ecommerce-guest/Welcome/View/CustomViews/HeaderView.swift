//
//  HeaderView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//

import UIKit

class HeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let flagImageView = UIImageView() // Nueva propiedad para la bandera
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Configurar título
        titleLabel.text = "Tienda de venta de camisetas para programadores" // Cambia el texto por el tuyo
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        // Permitir múltiples líneas y ajustar el modo de salto de línea
        titleLabel.numberOfLines = 0 // Permite múltiples líneas
        titleLabel.lineBreakMode = .byWordWrapping // Ajusta el texto para saltar de línea
        
        // Configurar logo
        logoImageView.image = UIImage(named: "logo-white") // Asegúrate de que "logo" está en tus recursos
        logoImageView.contentMode = .scaleAspectFit
        
        // Configurar la bandera
        flagImageView.image = UIImage(named: "flag_spain") // Asegúrate de que "flag_spain" está en tus recursos
        flagImageView.contentMode = .scaleAspectFit
        
        // Agregar sub-vistas
        addSubview(flagImageView)
        addSubview(titleLabel)
        addSubview(logoImageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ajustar el frame de la bandera
        let flagSize: CGFloat = 20 // Ajusta el tamaño de la bandera según sea necesario
        flagImageView.frame = CGRect(x: 20, y: 60, width: flagSize, height: flagSize) // Espaciado superior y posición
        
        // Ajustar el frame del título
        let titleX = flagImageView.frame.maxX + 8 // Espacio entre la bandera y el texto
        let maxLabelWidth = self.frame.width - titleX - 20 // Ancho máximo para el label
        let labelSize = titleLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: titleX,
                                  y: 60, // Espaciado superior
                                  width: maxLabelWidth,
                                  height: labelSize.height) // Ajusta la altura según tus necesidades
        
        // Ajustar la altura de la bandera para que coincida con la altura del título
        flagImageView.frame.size.height = titleLabel.frame.height
        
        // Ajustar el frame del logo
        let logoWidth: CGFloat = 200 // Ajusta el tamaño según tus necesidades
        let logoHeight: CGFloat = 200
        logoImageView.frame = CGRect(x: (self.frame.width - logoWidth) / 2,
                                      y: titleLabel.frame.maxY + 5, // Espaciado debajo del título
                                      width: logoWidth,
                                      height: logoHeight)
        
    }
}
