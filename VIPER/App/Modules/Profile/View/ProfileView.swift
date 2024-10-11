//
//  ProfileView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 11/10/24.
//  
//

import Foundation
import UIKit

class ProfileView: UIViewController {

    // MARK: Properties
    var presenter: ProfilePresenterProtocol?
    
    // Crear una instancia de ProfileTableView
    private let profileTableView = ProfileTableView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
        configureTableView()
    }
    
    private func setupView() {
        title = "Perfil"
        view.backgroundColor = .systemGray4
        
        // Añadir profileTableView a la vista principal
        view.addSubview(profileTableView)
        
        // Configurar las constraints para que la tabla ocupe toda la pantalla
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Agregar el botón de cerrar sesión en el footer
        setupTableFooterView()
    }
    
    
    func configureTableView() {
        // Configurar el delegado y el dataSource
        profileTableView.tableView.dataSource = self
        profileTableView.tableView.delegate = self
        
        profileTableView.tableView.reloadData()
    }
    
    private func setupTableFooterView() {
        // Crear el footerView que contendrá el botón
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        // Crear el botón de "Cerrar sesión"
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Cerrar sesión", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.layer.cornerRadius = 8
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Añadir el botón a la vista footerView
        footerView.addSubview(logoutButton)
        
        // Constraints del botón
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Asignar la vista footerView a la tableView
        profileTableView.tableView.tableFooterView = footerView
    }
}


// MARK: - ProfileViewProtocol
extension ProfileView: ProfileViewProtocol {
    // TODO: implement view output methods
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension ProfileView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //presenter?.numberOfOptions() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionCell", for: indexPath)
        //cell.textLabel?.text = presenter?.optionTitle(for: indexPath.row)
        //cell.accessoryType = .disclosureIndicator // Añade el icono de '>'
        //cell.backgroundColor = .darkGray
        //return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileOptionCell.identifier, for: indexPath) as? ProfileOptionCell else {
            return UITableViewCell()
        }
        
        // Configurar la celda con el título adecuado
        let titles = ["Mis compras", "Devoluciones", "Mis datos", "Mis direcciones", "Ayuda", "Cerrar sesión"]
        cell.configure(with: titles[indexPath.row])
        
        return cell
    }
 
    // Modificar la altura de las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // Altura personalizada para las celdas
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Aquí puedes manejar la navegación según la opción seleccionada
    }
}
