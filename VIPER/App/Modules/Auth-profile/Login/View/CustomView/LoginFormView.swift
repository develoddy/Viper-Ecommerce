//
//  LoginFormView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 4/10/24.
//

import UIKit

// MARK: UI
class LoginFormView: UIView {
    
    //var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let gradient = CAGradientLayer()
    
    public let headerView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }()
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Inicia sesión"
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    public let emailLabel : UILabel = {
        let label = UILabel()
        label.text = "EMAIL"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public let passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Constraseña"
        label.textAlignment = .left
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public let emailText : TextFieldWithPadding = {
        let emailText = TextFieldWithPadding()
        emailText.placeholder = "Correo electrónico"
        emailText.text = "eddylujann@gmail.com"
        emailText.returnKeyType = .next
        emailText.leftViewMode = .always
        emailText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailText.autocapitalizationType = .none
        emailText.autocorrectionType = .no
        emailText.layer.masksToBounds = true
        emailText.textColor = .black
        emailText.backgroundColor = .systemBackground
        return emailText
    }()
    
    public let passwordText : TextFieldWithPadding = {
        let passwordText = TextFieldWithPadding()
        passwordText.isSecureTextEntry = true
        passwordText.placeholder = "Introduzca su contraseña"
        passwordText.text = "secret"
        passwordText.returnKeyType = .continue
        passwordText.leftViewMode = .always
        passwordText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordText.autocapitalizationType = .none
        passwordText.autocorrectionType = .no
        passwordText.layer.masksToBounds = true
        passwordText.textColor =  .black
        passwordText.backgroundColor = .systemBackground
        return passwordText
    }()
    
    
    public let loginButton : LoadingButton = {
        let button = LoadingButton()
        button.setTitle("Iniciar sesión", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    public let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Crear cuenta", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    
    public let forgottenPasswordButton : UIButton = {
        let button = UIButton()
        button.setTitle("¿Has olvidado tu contraseña?", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        // button.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // SETUP
    private func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(headerView)
        
        //addSubview(emailLabel)
        addSubview(emailText)
        
        //addSubview(passwordLabel)
        addSubview(passwordText)
        
        addSubview(loginButton)
        
        addSubview(createAccountButton)
        addSubview(forgottenPasswordButton)
    }
    
    // LAYOUT SUB VIEWS
    override func layoutSubviews() {
        
        let padding: CGFloat = 20 // Ajusta este valor para mover el label más abajo
        
        // Header view
        let headerHeight: CGFloat = 200 // Define la altura deseada para el headerView
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: headerHeight)
        
        // Title label
        titleLabel.numberOfLines = 0  // Permite múltiples líneas
        titleLabel.lineBreakMode = .byWordWrapping  // Ajusta el texto para saltar de línea
        let labelHeight = titleLabel.sizeThatFits(CGSize(width: self.frame.width - 40, height: CGFloat.greatestFiniteMagnitude)).height
        
        titleLabel.frame = CGRect(
            x: 20,
            y: (headerHeight - labelHeight) / 2 + padding, // Centrando verticalmente
            width: self.frame.width - 40,
            height: labelHeight
        )
        
        // Input email
        emailText.frame = CGRect(
            x: 25,
            y: headerView.bottom+padding,
            width: width-50,
            height: 50
        ).integral
        
        // Input password
        passwordText.frame = CGRect(
            x:25, 
            y: emailText.bottom+padding,
            width:width-50, 
            height: 50
        ).integral
        
        // Button login
        loginButton.frame = CGRect(
            x:25,
            y: passwordText.bottom+padding+20,
            width: width-50,
            height:50
        )
        
        // Button create account
        createAccountButton.frame = CGRect(
            x:25,
            y:loginButton.bottom+padding,
            width: width-50,
            height: 52.0
        )
        
        // Forgotten Password
        forgottenPasswordButton.frame = CGRect(
            x:10, 
            y:createAccountButton.bottom+padding, 
            width:width-20,
            height: 50
        )
    }
    
    
    // HEADER VIEW
    func configureHeaderView() {
        // COLOR HEADER
        headerView.clipsToBounds = true
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBackground.cgColor]
        gradient.locations = [0.0, 0.6, 0.8]
        gradient.frame = self.bounds
        headerView.layer.insertSublayer(gradient, at: 0)
        
        // LOHO
        logoImageView.backgroundColor = .systemBackground
        logoImageView.layer.masksToBounds = true
        
        // ADD LOGO & TITLE
        headerView.addSubview(logoImageView)
        headerView.addSubview(titleLabel)
    }
}
