//
//  WelcomeView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//  
//

import Foundation
import UIKit

class WelcomeView: UIViewController {

    // MARK: Properties
    var presenter: WelcomePresenterProtocol?
    
    // Custom welcome image view
    private let welcomeItemView = WelcomeItemView()
    private let headerView = HeaderView() // Agregamos el encabezado
    
    // Label encima del botón continuar
    private let continueLabel = UILabel()
    
    // Continue button
    private let continueButton = UIButton()
    private let createAccountButton = UIButton()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        // Set the bakcground color
        view.backgroundColor = .white
        
        // Add HeaderView, WelcomeItemView, and ContinueButton to the view hierarchy
        welcomeItemView.setImage(named: "welcome_background-2")
        view.addSubview(welcomeItemView)
        
        view.addSubview(headerView)
        
        // Configure continueLabel (Texto encima del botón continuar)
        continueLabel.text = "Sumergéte en el estilo y la cultura mediteránea"
        continueLabel.font = UIFont.boldSystemFont(ofSize: 34)
        continueLabel.textAlignment = .left
        continueLabel.textColor = .white
        view.addSubview(continueLabel)
        
        // Configure continueButton
        continueButton.setTitle("Continuar", for: .normal)
        continueButton.backgroundColor = .white
        continueButton.setTitleColor(.black, for: .normal) // Letra en blanco
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        view.addSubview(continueButton)
        
        // Configure createAccountButton
        createAccountButton.setTitle("Crear cuenta", for: .normal)
        createAccountButton.backgroundColor = .clear
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.layer.borderColor = UIColor.white.cgColor // Color del borde
        createAccountButton.layer.borderWidth = 1.0 // Ancho del borde
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
       view.addSubview(createAccountButton) // Agregar el botón Crear cuenta
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Definir el frame del header
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0) // Ajusta la altura según sea necesario
        
        // Definir el frame de welcomeItemView para ocupar el espacio restante debajo del header
        welcomeItemView.frame = CGRect(x: 0,
                                       y: headerView.frame.maxY, // Empieza justo debajo del header
                                       width: view.frame.width,
                                       height: view.frame.height - headerView.frame.height) // 70 para el botón
        
        // Configurar el label para que no se corte el texto
        continueLabel.numberOfLines = 0  // Permite múltiples líneas
        continueLabel.lineBreakMode = .byWordWrapping  // Ajusta el texto para saltar de línea
        
        // Definir el frame de la etiqueta de texto (continueLabel) con más espacio
        let labelHeight = continueLabel.sizeThatFits(CGSize(width: view.frame.width - 40, height: CGFloat.greatestFiniteMagnitude)).height
        continueLabel.frame = CGRect(x: 20, y: view.frame.height - view.safeAreaInsets.bottom - 320, width: view.frame.width - 40, height: labelHeight)
        
        // Definir el frame del continueButton para estar en la parte inferior de la pantalla
        let buttonHeight: CGFloat = 50
        let buttonWidth = view.frame.width - 40 // Márgenes de 20 a cada lado
        let buttonX: CGFloat = 20
        let continueButtonY = continueLabel.frame.maxY + 20 //view.frame.height - view.safeAreaInsets.bottom - buttonHeight - 100 // 20 de padding inferior
        continueButton.frame = CGRect(x: buttonX, y: continueButtonY, width: buttonWidth, height: buttonHeight)
        
        // Definir el frame del createAccountButton para estar debajo del continueButton
        let createAccountButtonY = continueButton.frame.maxY + 20// 10 de padding entre botones
        createAccountButton.frame = CGRect(x: buttonX, y: createAccountButtonY, width: buttonWidth, height: buttonHeight)
    }
    
    @objc private func continueButtonTapped() {
        //presenter?.didTapContinue()
        presenter?.didTapContinue() // Llama al método en el presenter
    }
    
    @objc private func createAccountButtonTapped() {
        //presenter?.didTapCreateAccount()
    }
}

extension WelcomeView: WelcomeViewProtocol {
    // TODO: implement view output methods
}
