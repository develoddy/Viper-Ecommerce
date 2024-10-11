//
//  ProfileTableView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 12/10/24.
//

import UIKit

class ProfileTableView: UIView {

    // Crear UITableView
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProfileOptionCell.self, forCellReuseIdentifier: ProfileOptionCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Añadir la tableView como subview
        addSubview(tableView)
        
        // Configurar las constraints de la tabla para ocupar todo el espacio de la vista
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // Configurar la cabecera
        setupTableHeaderView()
    }
    
    private func setupTableHeaderView() {
       // Crear la vista de cabecera
       let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
       headerView.backgroundColor = .systemGray6
       
       // Crear el UILabel para el nombre del perfil
       let nameLabel = UILabel()
       nameLabel.text = "Nombre del Perfil"
       nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
       nameLabel.textColor = .label
       nameLabel.translatesAutoresizingMaskIntoConstraints = false
       
       // Añadir nameLabel a la cabecera
       headerView.addSubview(nameLabel)
       
       // Configurar constraints de nameLabel
       NSLayoutConstraint.activate([
           nameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
           nameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
       ])
       
       // Asignar la cabecera a la tableView
       tableView.tableHeaderView = headerView
   }
}
