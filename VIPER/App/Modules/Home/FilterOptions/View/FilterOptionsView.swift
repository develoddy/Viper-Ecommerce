//
//  FilterOptionsView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

class FilterOptionsView: UIViewController {

    // MARK: Properties
    var presenter: FilterOptionsPresenterProtocol?
    private let filterOptionsItemView = FilterOptionsItemView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFilterOptionsItemView()
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterOptionsItemView.frame = view.bounds
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(filterOptionsItemView)

        // Configura el delegate y dataSource de homeUI
        //homeItemView.collectionView.dataSource = self
        //homeItemView.collectionView.delegate = self
    
        // COMUNICO A MI VISTA CON EL PRESENTER
        presenter?.viewDidLoad()
    }
    
    private func setupFilterOptionsItemView() {
        view.addSubview(filterOptionsItemView)
        filterOptionsItemView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints para el FilterOptionsItemView
        NSLayoutConstraint.activate([
            filterOptionsItemView.topAnchor.constraint(equalTo: view.topAnchor),
            filterOptionsItemView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filterOptionsItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterOptionsItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Maneja la selección de opciones
        filterOptionsItemView.onOptionSelected = { [weak self] selectedOption in
            print("Opción seleccionada en SortOptionsViewController: \(selectedOption)")
            // Aquí puedes manejar lo que sucede cuando se selecciona una opción
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension FilterOptionsView: FilterOptionsViewProtocol {
    // TODO: implement view output methods
}
