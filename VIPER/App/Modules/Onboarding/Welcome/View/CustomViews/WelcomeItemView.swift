//
//  WelcomeItemView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//

import UIKit

class WelcomeItemView: UIView {

    private let imageView = UIImageView()
    private let overlayView = UIView() // Capa de superposición
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Configure imageView to fill the entire view
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // This ensures that the image doesn't overflow outside its bounds
        addSubview(imageView)
        
        // Configurar overlayView (capa de superposición) para oscurecer la imagen
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.7) // Ajusta el nivel de opacidad aquí
        addSubview(overlayView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        // Make the imageView occupy the entire view
        imageView.frame = self.bounds
        overlayView.frame = self.bounds
        //let padding: CGFloat = 20
        
        //let imageViewWidth = self.frame.width - (2 * padding)
        //let imageViewHeight = self.frame.height * 0.4 // Ocupies 40% of the height
        //let imageViewX = padding
        //let imageViewY = (self.frame.height - imageViewHeight)/2 // Centered vertically
        
        // Assing the calculated frame to the imageView
        //imageView.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewWidth, height: imageViewHeight)
    }
    
    func setImage(named imageName: String) {
        imageView.image = UIImage(named: imageName)
    }

}
