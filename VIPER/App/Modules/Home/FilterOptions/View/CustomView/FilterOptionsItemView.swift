//
//  FilterOptionsItemView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//

import UIKit

import UIKit

class FilterOptionsItemView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let options = ["Precio", "Calificación", "Popularidad"]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Un closure para manejar la selección
    var onOptionSelected: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Constraints para la tabla
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Registra una celda simple para la tabla
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SortOptionCell")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOptionCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        print("Seleccionado: \(selectedOption)")
        
        // Llama al closure cuando se selecciona una opción
        onOptionSelected?(selectedOption)
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

